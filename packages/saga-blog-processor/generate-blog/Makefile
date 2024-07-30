push-to-ecr:
	cd ../../../ && docker build -t mycontent/production/ecs/tasks/generate-blog -f packages/saga-blog-processor/generate-blog/Dockerfile .
	docker tag mycontent/production/ecs/tasks/generate-blog:latest 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/tasks/generate-blog:latest
	docker push 474489807730.dkr.ecr.us-east-1.amazonaws.com/mycontent/production/ecs/tasks/generate-blog:latest

generate-proto:
	python -m grpc_tools.protoc --python_out=. --grpc_python_out=. -I ../../shared/proto ../../shared/proto/blog.proto
