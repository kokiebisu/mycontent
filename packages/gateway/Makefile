ACCOUNT_ID := 746669204470
REGION := ap-northeast-1

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

push-to-ecr:
	cd ../../ && docker build --platform linux/amd64 -t mycontent/develop/ecs/gateway -f packages/gateway/Dockerfile .
	docker tag mycontent/develop/ecs/gateway:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/develop/ecs/gateway:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/develop/ecs/gateway:latest
