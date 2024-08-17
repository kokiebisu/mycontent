ACCOUNT_ID := 746669204470
REGION := ap-northeast-1

build:
	docker compose up --build

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

deploy-lambdas:
	./scripts/deploy-lambdas.sh

deploy-tasks:
	./scripts/deploy-tasks.sh

deploy-services:
	./scripts/deploy-services.sh
