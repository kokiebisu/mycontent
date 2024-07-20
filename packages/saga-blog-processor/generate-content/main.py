
def lambda_handler(event, context):
    print('ENTERED1', event)
    # sanitized_groups = event['sanitized_groups']
    
    # content = []
    # for group in sanitized_groups:
    #     prompt = "Generate a blog post based on the following conversations:\n\n"
    #     prompt += "\n".join(group)
        
    #     response = client.chat.completions.create(
    #         model="gpt-3.5-turbo",
    #         messages=[
    #             {"role": "system", "content": "You are a professional blog writer."},
    #             {"role": "user", "content": prompt}
    #         ],
    #         max_tokens=500
    #     )
        
        # content.append(response.choices[0].message.content)
    
    return {
        'status': 'success'
    }
