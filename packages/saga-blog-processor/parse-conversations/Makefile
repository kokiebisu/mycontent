push-to-ecr:
	docker build -t mycontent/production/lambda/parse-conversations .
	docker tag mycontent/production/lambda/parse-conversations:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/lambda/parse-conversations:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/lambda/parse-conversations:latest

push-and-deploy-prod:
	make push-to-ecr
	aws lambda update-function-code --function-name production-parse-conversations --image-uri 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/lambda/parse-conversations:latest
