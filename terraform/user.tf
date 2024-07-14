# Create ECS service for the user service
resource "aws_ecs_service" "user" {
  name             = "user"
  cluster          = aws_ecs_cluster.main.id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnets.default.ids
  }

  task_definition = aws_ecs_task_definition.user.arn

  lifecycle {
    ignore_changes = [task_definition, desired_count]
    create_before_destroy = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.user.arn
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_service_discovery_service" "user" {
  name = "user"

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

# Create task definition for the user service
resource "aws_ecs_task_definition" "user" {
  family                   = "user"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "service-user"
      image = local.service_images["service-user"]
      portMappings = [
        {
          containerPort = 4003
          hostPort      = 4003
        },
        {
          containerPort = 50053
          hostPort      = 50053
        }
      ]
      environment = [
        {
          name = "GRAPHQL_PORT",
          value = "4003"
        },
        {
          name = "USER_GRPC_PORT",
          value = "50053"
        },
        {
          name = "DB_PORT",
          value = "5432"
        },
        {
          name = "DB_HOST",
          value = aws_db_instance.default.address
        },
        {
          name = "DB_USER",
          value = "postgres"
        },
        {
          name = "DB_NAME",
          value = "mydb"
        },
        {
          name = "DB_PASSWORD",
          value = "mypassword"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.user.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  runtime_platform {
    cpu_architecture = "ARM64"
  } 

  tags = {
    Environment = "production"
  }
}

# Create CloudWatch log groups for the new services
resource "aws_cloudwatch_log_group" "user" {
  name              = "/ecs/${local.namespace}/user"
  retention_in_days = 30

  tags = {
    Environment = "production"
  }
}