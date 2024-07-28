push-to-ecr:
	cd ../../ && docker build -t mycontent/production/ecs/service-blog -f packages/service-blog/Dockerfile .
	docker tag mycontent/production/ecs/service-blog:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/service-blog:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/service-blog:latest
