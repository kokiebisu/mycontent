ecr-login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 474489807730.dkr.ecr.us-east-1.amazonaws.com

deploy-prod:
	cd ../../ && docker build -t mycontent/production/service-blog -f packages/service-blog/Dockerfile .
	docker tag mycontent/production/service-blog:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/service-blog:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/service-blog:latest
