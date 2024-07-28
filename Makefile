build:
	docker compose up --build

ecr-login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 474489807730.dkr.ecr.us-east-1.amazonaws.com
