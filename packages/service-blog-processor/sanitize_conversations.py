import re

def sanitize_conversation(conversation):
    return re.sub(r'(email|phone|address):\s*\S+', '[REDACTED]', conversation)

def lambda_handler(event, context):
    grouped_conversations = event['grouped_conversations']
    
    sanitized_groups = [
        [sanitize_conversation(conv) for conv in group]
        for group in grouped_conversations
    ]
    
    return {
        'sanitized_groups': sanitized_groups
    }
