ACCOUNT_ID := 746669204470
REGION := us-east-1

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

push-to-ecr:
	cd ../../ && docker build -t mycontent/development/ecs/service/authentication -f packages/service-authentication/Dockerfile .
	docker tag mycontent/development/ecs/service/authentication:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/ecs/service/authentication:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/ecs/service/authentication:latest
