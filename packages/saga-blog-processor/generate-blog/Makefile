push-to-ecr:
	docker build -t mycontent/production/lambda/generate-blog .
	docker tag mycontent/production/lambda/generate-blog:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/lambda/generate-blog:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/lambda/generate-blog:latest

push-and-deploy-prod:
	make push-to-ecr
	aws lambda update-function-code --function-name production-generate-blog --image-uri 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/lambda/generate-blog:latest
