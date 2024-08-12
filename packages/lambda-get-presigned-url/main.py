import boto3
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    # Extract parameters from the event
    bucket_name = event.get('bucketName')
    file_name = event.get('fileName')
    file_type = event.get('fileType')

    if not all([bucket_name, file_name, file_type]):
        return {
            'statusCode': 400,
            'body': 'Missing required parameters'
        }

    try:
        # Create an S3 client
        s3_client = boto3.client('s3')

        # Generate a presigned URL for PUT operation
        presigned_url = s3_client.generate_presigned_url(
            'put_object',
            Params={
                'Bucket': bucket_name,
                'Key': file_name,
                'ContentType': file_type
            },
            ExpiresIn=900  # URL expires in 15 minutes (900 seconds)
        )

        return {
            'statusCode': 200,
            'body': presigned_url
        }

    except ClientError as e:
        return {
            'statusCode': 500,
            'body': f'Failed to generate presigned URL: {str(e)}'
        }