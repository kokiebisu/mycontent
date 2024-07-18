import json
import boto3

def lambda_handler(event, context):
    print('ENTERED1')
    s3 = boto3.client('s3')
    bucket = event['bucket']
    key = event['key']
    
    response = s3.get_object(Bucket=bucket, Key=key)
    conversations = json.loads(response['Body'].read().decode('utf-8'))

    print(f'Conversations: {conversations}')
    
    return {
        'conversations': conversations
    }
