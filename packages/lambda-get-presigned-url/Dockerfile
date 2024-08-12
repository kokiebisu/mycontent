FROM public.ecr.aws/lambda/python:3.11

COPY ./packages/lambda-get-presigned-url/requirements.txt ${LAMBDA_TASK_ROOT}/requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY ./packages/lambda-get-presigned-url/main.py ${LAMBDA_TASK_ROOT}

CMD ["main.lambda_handler"]
