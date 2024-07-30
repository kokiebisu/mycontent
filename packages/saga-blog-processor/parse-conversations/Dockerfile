FROM public.ecr.aws/lambda/python:3.11

COPY ./packages/saga-blog-processor/parse-conversations/requirements.txt ${LAMBDA_TASK_ROOT}/requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY ./packages/saga-blog-processor/parse-conversations/main.py ${LAMBDA_TASK_ROOT}

CMD [ "main.lambda_handler" ]
