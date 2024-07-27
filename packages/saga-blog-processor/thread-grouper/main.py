import boto3
import json

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
        'title': conversation['title'],
        'question': mapping_items[3][1]['message']['content']['parts'][0] if len(mapping_items) >= 4 else '',
        'thread': [{
            'role': item[1]['message']['author']['role'],
            'content': item[1]['message']['content']['parts'][0]
        } for item in mapping_items[5:]]
    }

def store_conversation(bucket_name, key, conversation):
    s3 = boto3.client('s3') 
    s3.put_object(Bucket=bucket_name, Key=key, Body=json.dumps(conversation))

def lambda_handler(event, context):
    '''
    This lambda will get triggered when the user uploads a new OpenAI export (conversations.json)
    inside the bucket. The purpose of this lambda is to split the conversations by threads and store
    them seperately in s3 to achieve parallel blog generation of the respective threads.
    '''
    print("Event: ", event)
    bucket_name = event['detail']['bucket']['name']
    key = event['detail']['object']['key']
    result = []
    conversations = load_conversations(bucket_name=bucket_name, key=key)
    for c in conversations:
        transformed = transform(c)
        result.append(transformed)

    return {
        'bucket_name': bucket_name,
        'key': key,
        'result': result
    }
