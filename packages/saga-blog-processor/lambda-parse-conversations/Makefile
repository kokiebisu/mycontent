ACCOUNT_ID := 746669204470
REGION := ap-northeast-1

push-to-ecr:
	cd ../../../ && docker build -t mycontent/develop/lambda/parse-conversations -f packages/saga-blog-processor/lambda-parse-conversations/Dockerfile .
	docker tag mycontent/develop/lambda/parse-conversations:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/develop/lambda/parse-conversations:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/develop/lambda/parse-conversations:latest

push-and-deploy-develop:
	make push-to-ecr
	aws lambda update-function-code --function-name develop-parse-conversations --image-uri $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/develop/lambda/parse-conversations:latest
