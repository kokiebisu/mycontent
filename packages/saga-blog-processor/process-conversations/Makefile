deploy-dev:
	zip -r lambda_function.zip . -x '*.git*' '*.zip' 'Makefile' 'Dockerfile'

deploy-prod:
	docker build -t localhost:5001/process-conversations .
	docker push localhost:5001/process-conversations