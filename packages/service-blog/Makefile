ACCOUNT_ID := 746669204470
REGION := us-east-1

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

push-to-ecr:
	cd ../../ && docker build -t mycontent/development/ecs/service/blog -f packages/service-blog/Dockerfile .
	docker tag mycontent/development/ecs/service/blog:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/ecs/service/blog:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/ecs/service/blog:latest
