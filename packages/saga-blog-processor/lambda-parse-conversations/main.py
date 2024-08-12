import hashlib
import boto3
import json
import uuid
import time

def load_conversations(bucket_name, key):
    '''
    Load conversations.json from the s3 bucket
    '''
    s3 = boto3.client('s3') 
    response = s3.get_object(Bucket=bucket_name, Key=key)
    return json.loads(response['Body'].read().decode('utf-8'))

def transform(conversation):
    mapping_items = list(conversation['mapping'].items())
    return {
        'id': str(uuid.uuid4()),  # Generate a unique ID for each conversation
        'title': conversation['title'],
        'question': mapping_items[3][1]['message']['content']['parts'][0] if len(mapping_items) >= 4 else '',
        'thread': [{
            'id': hashlib.sha256(item[1]['message']['content']['parts'][0].encode('utf-8')).hexdigest(),
            'role': item[1]['message']['author']['role'],
            'content': item[1]['message']['content']['parts'][0]
        } for item in mapping_items[5:]]
    }

def store_conversation(conversation, environment):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(f'{environment}-conversation-store')
    expiration_time = int(time.time()) + 86400  # 24 hours from now
    conversation['expiration_time'] = expiration_time
    table.put_item(Item=conversation)
    return conversation['id']

def lambda_handler(event, context):
    '''
    This lambda will get triggered when the user uploads a new OpenAI export (conversations.json)
    inside the bucket. The purpose of this lambda is to split the conversations by threads and store
    them separately in DynamoDB to achieve parallel blog generation of the respective threads.
    '''
    print("Event: ", event)
    environment = event.get('environment')
    if not environment:
        raise ValueError("Environment not provided in the event")

    detail = event.get('detail', {})
    bucket_name = detail.get('bucket', {}).get('name')
    key = detail.get('object', {}).get('key')

    if not bucket_name or not key:
        raise ValueError("Bucket name or key not found in the event")

    conversations = load_conversations(bucket_name=bucket_name, key=key)
    conversation_ids = []
    
    for c in conversations:
        transformed = transform(c)
        conversation_id = store_conversation(transformed, environment)
        conversation_ids.append(conversation_id)

    print(f'Stored {len(conversation_ids)} conversations')

    return {
        'status': 'success',
        'bucket_name': bucket_name,
        'key': key,
        'conversation_ids': conversation_ids
    }