ACCOUNT_ID := 746669204470
REGION := ap-northeast-1

ecr-login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

push-to-ecr:
	cd ../../../ && docker build -t mycontent/develop/ecs/task/generate-blog -f packages/saga-blog-processor/task-generate-blog/Dockerfile .
	docker tag mycontent/develop/ecs/task/generate-blog:latest $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/develop/ecs/task/generate-blog:latest
	docker push $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/mycontent/develop/ecs/task/generate-blog:latest

generate-proto:
	python -m grpc_tools.protoc --python_out=. --grpc_python_out=. -I ../../shared/proto ../../shared/proto/blog.proto
