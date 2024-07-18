import boto3

def lambda_handler(event, context):
    generated_content = event['generated_content']
    
    s3 = boto3.client('s3')
    bucket = 'your-output-bucket-name'
    
    for i, blog in enumerate(generated_content):
        key = f'generated_blogs/blog_{i+1}.txt'
        s3.put_object(Bucket=bucket, Key=key, Body=blog.encode('utf-8'))
    
    return {
        'message': f'Successfully saved {len(generated_content)} blogs'
    }
