ecr-login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 474489807730.dkr.ecr.us-east-1.amazonaws.com

deploy-prod:
	make ecr-login
	docker build -t mycontent/production/process-conversations .
	docker tag mycontent/production/process-conversations:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/process-conversations:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/process-conversations:latest
