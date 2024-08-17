ACCOUNT_ID := 746669204470
REGION := ap-northeast-1

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

push-to-ecr:
	cd ../../ && docker build -t mycontent/develop/ecs/service/authentication -f packages/service-authentication/Dockerfile .
	docker tag mycontent/develop/ecs/service/authentication:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/develop/ecs/service/authentication:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/develop/ecs/service/authentication:latest
