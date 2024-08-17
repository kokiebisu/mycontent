ACCOUNT_ID := 746669204470
REGION := ap-northeast-1

push-to-ecr:
	cd ../../../ && docker build -t mycontent/development/lambda/parse-conversations -f packages/saga-blog-processor/lambda-parse-conversations/Dockerfile .
	docker tag mycontent/development/lambda/parse-conversations:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/lambda/parse-conversations:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/lambda/parse-conversations:latest

push-and-deploy-dev:
	make push-to-ecr
	aws lambda update-function-code --function-name dev-parse-conversations --image-uri $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/lambda/parse-conversations:latest
