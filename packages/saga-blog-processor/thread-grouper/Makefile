ecr-login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 474489807730.dkr.ecr.us-east-1.amazonaws.com

push-to-ecr:
	make ecr-login
	docker build -t mycontent/production/thread-grouper .
	docker tag mycontent/production/thread-grouper:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/thread-grouper:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/thread-grouper:latest

push-and-deploy-prod:
	make push-to-ecr
	aws lambda update-function-code --function-name thread_grouper --image-uri 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/thread-grouper:latest
