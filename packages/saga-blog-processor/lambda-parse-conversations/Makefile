ACCOUNT_ID := 746669204470
REGION := ap-northeast-1

push-to-ecr:
	cd ../../../ && docker build -t mycontent/production/lambda/parse-conversations -f packages/saga-blog-processor/lambda-parse-conversations/Dockerfile .
	docker tag mycontent/production/lambda/parse-conversations:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/production/lambda/parse-conversations:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/production/lambda/parse-conversations:latest

push-and-deploy-prod:
	make push-to-ecr
	aws lambda update-function-code --function-name production-parse-conversations --image-uri $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/production/lambda/parse-conversations:latest
