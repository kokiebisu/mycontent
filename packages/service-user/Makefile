ACCOUNT_ID := 746669204470
REGION := ap-northeast-1

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

push-to-ecr:
	cd ../../ && docker build -t mycontent/production/ecs/service/user -f packages/service-user/Dockerfile .
	docker tag mycontent/production/ecs/service/user:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/production/ecs/service/user:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/production/ecs/service/user:latest
