ecr-login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 474489807730.dkr.ecr.us-east-1.amazonaws.com

deploy-prod:
	cd ../../ && docker build -t mycontent/production/service-user -f packages/service-user/Dockerfile .
	docker tag mycontent/production/service-user:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/service-user:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/service-user:latest
