push-to-ecr:
	cd ../../ && docker build --platform linux/amd64 -t mycontent/production/ecs/gateway -f packages/gateway/Dockerfile .
	docker tag mycontent/production/ecs/gateway:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/gateway:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/gateway:latest
