resource "aws_ecs_service" "user" {
  name             = "user"
  cluster          = var.cluster_id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [var.ecs_task_security_group_id]
    subnets          = var.subnet_ids
  }

  task_definition = aws_ecs_task_definition.user.arn

  lifecycle {
    ignore_changes = [task_definition, desired_count]
    create_before_destroy = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.user.arn
  }

  force_new_deployment = true

  tags = {
    Environment = var.environment
  }
}

resource "aws_service_discovery_service" "user" {
  name = "user"

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

resource "aws_ecs_task_definition" "user" {
  family                   = "user"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "service-user"
      image = var.service_image
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
          value = var.db_host
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
        },
        {
          name = "ENVIRONMENT",
          value = var.environment
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.service_user.name
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
