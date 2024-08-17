ACCOUNT_ID := 746669204470
REGION := ap-northeast-1

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

push-to-ecr:
	docker build -t mycontent/development/ecs/web .
	docker tag mycontent/development/ecs/web:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/ecs/web:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/ecs/web:latest
