ecr-login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 474489807730.dkr.ecr.us-east-1.amazonaws.com

push-to-ecr:
	make ecr-login
	cd ../../ && docker build -t mycontent/production/ecs/service/authentication -f packages/service-authentication/Dockerfile .
	docker tag mycontent/production/ecs/service/authentication:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/service/authentication:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/service/authentication:latest
