ACCOUNT_ID := 746669204470
REGION := us-east-1

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

push-to-ecr:
	cd ../../ && docker build -t mycontent/development/lambda/get-presigned-url -f packages/lambda-get-presigned-url/Dockerfile .
	docker tag mycontent/development/lambda/get-presigned-url:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/lambda/get-presigned-url:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/lambda/get-presigned-url:latest

push-and-deploy-dev:
	make push-to-ecr
	aws lambda update-function-code --function-name dev-get-presigned-url --image-uri $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/lambda/get-presigned-url:latest
