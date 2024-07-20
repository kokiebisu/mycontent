# Create ECS service for the authentication service
resource "aws_ecs_service" "authentication" {
  name             = "authentication"
  cluster          = aws_ecs_cluster.main.id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [var.ecs_task_security_group_id]
    subnets          = var.subnet_ids
  }

  task_definition = aws_ecs_task_definition.authentication.arn

  lifecycle {
    ignore_changes = [task_definition, desired_count]
    create_before_destroy = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.authentication.arn
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_service_discovery_service" "authentication" {
  name = "authentication"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.internal.id
    
    dns_records {
      ttl  = 10
      type = "A"
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

# Create task definition for the authentication service
resource "aws_ecs_task_definition" "authentication" {
  family                   = "authentication"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "service-authentication"
      image = var.service_images["service-authentication"]
      portMappings = [
        {
          containerPort = 4001
          hostPort      = 4001
        }
      ]
      environment = [
        {
          name = "GRAPHQL_PORT",
          value = "4001"
        },
        {
          name = "USER_GRPC_PORT",
          value = "50053"
        },
        {
          name = "USER_SERVICE_HOST",
          value = "user.mycontent.internal"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.service_authentication.name
          awslogs-region        = var.region_name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  runtime_platform {
    cpu_architecture = "ARM64"
  } 

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "service_authentication" {
  name              = "/ecs/${var.environment}/service-authentication"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}
