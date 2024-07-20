import json
import boto3
# from langchain.text_splitter import RecursiveCharacterTextSplitter
# from langchain.vectorstores import FAISS
# from langchain.embeddings import HuggingFaceEmbeddings
from langchain.docstore.document import Document

def lambda_handler(event, context):
    try:
        s3 = boto3.client('s3')
        bucket_name = event['detail']['bucket']['name']
        key = event['detail']['object']['key']
        
        response = s3.get_object(Bucket=bucket_name, Key=key)
        conversations = json.loads(response['Body'].read().decode('utf-8'))

        # Extract conversation content
        docs = []
        for conversation in conversations:
            content = extract_conversation_content(conversation)
            docs.append(Document(page_content=content, metadata={"title": conversation['title']}))

        print("DOCS: ", docs)
        
        # Process the documents (you can add your processing logic here)
        
        # Store the result back to S3 or pass it to the next step
        result = {"processed_docs": len(docs)}
        s3.put_object(
            Bucket=bucket_name,
            Key=f"processed/{key}",
            Body=json.dumps(result)
        )
        
        return result
    except Exception as e:
        print(f"Error: {str(e)}")
        raise

def extract_conversation_content(conversation):
    content = []
    for node in conversation['mapping'].values():
        if node['message'] and 'content' in node['message']:
            parts = node['message']['content'].get('parts', [])
            content.extend(parts)
    return " ".join(content)
