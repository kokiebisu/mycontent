# Create ECS service for the gateway
resource "aws_ecs_service" "gateway" {
  name             = "gateway"
  cluster          = var.cluster_id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [var.ecs_task_security_group_id]
    subnets          = var.subnet_ids
  }

  task_definition = aws_ecs_task_definition.gateway.arn

  load_balancer {
    target_group_arn = var.lb_target_group_gateway_arn
    container_name   = "gateway"
    container_port   = 4000
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
    create_before_destroy = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.gateway.arn
  }

  force_new_deployment = true

  tags = {
    Environment = var.environment
  }
}

resource "aws_service_discovery_service" "gateway" {
  name = "gateway"

  dns_config {
    namespace_id = var.private_dns_namespace_id
    
    dns_records {
      ttl  = 10
      type = "A"
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

# Create task definition for the gateway service
resource "aws_ecs_task_definition" "gateway" {
  family                   = "gateway"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "gateway"
      image = var.service_image
      environment = [
        {
          name  = "AUTHENTICATION_SERVICE_URL"
          value = "http://authentication.mycontent.internal"
        },
        {
          name  = "BLOG_SERVICE_URL"
          value = "http://blog.mycontent.internal"
        },
        {
          name  = "USER_SERVICE_URL"
          value = "http://user.mycontent.internal"
        },
        {
          name = "GRAPHQL_PORT",
          value = "4000"
        },
        {
          name = "USER_GRPC_PORT",
          value = "50053"
        },
        {
          name = "ENVIRONMENT",
          value = var.environment
        }
      ]
      portMappings = [
        {
          containerPort = 4000
          hostPort      = 4000
        }
      ] 
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.gateway.name
          awslogs-region        = var.region_name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  runtime_platform {
    cpu_architecture = "X86_64"
  } 

  tags = {
    Environment = var.environment
  }
}
