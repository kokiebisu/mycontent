push-to-ecr:
	cd ../../ && docker build -t mycontent/production/ecs/service-user -f packages/service-user/Dockerfile .
	docker tag mycontent/production/ecs/service-user:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/service-user:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/service-user:latest
