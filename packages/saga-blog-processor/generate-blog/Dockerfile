FROM python:3.9-slim

WORKDIR /app

COPY packages/saga-blog-processor/generate-blog/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY packages/saga-blog-processor/generate-blog/ ./

ENV PYTHONPATH=/app

CMD ["python", "-m", "main"]