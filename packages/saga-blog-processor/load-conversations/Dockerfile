# Use the AWS Lambda Python runtime as the base image
FROM public.ecr.aws/lambda/python:3.8

# Copy requirements.txt
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Install the specified packages
RUN pip install -r requirements.txt

# Copy function code
COPY process_conversations.py ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler
CMD [ "process_conversations.lambda_handler" ]
