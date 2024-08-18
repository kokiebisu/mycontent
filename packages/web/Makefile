ACCOUNT_ID := 746669204470
REGION := ap-northeast-1
API_HOST := external-alb-73547289.ap-northeast-1.elb.amazonaws.com

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

push-to-ecr:
	docker build --build-arg NEXT_PUBLIC_API_HOST=$(API_HOST) -t mycontent/development/ecs/web .
	docker tag mycontent/development/ecs/web:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/ecs/web:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/development/ecs/web:latest
