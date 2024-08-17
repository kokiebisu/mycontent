resource "aws_ecs_service" "web" {
  name = "web"
  cluster = var.cluster_id
  desired_count = 1
  launch_type = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups = [var.ecs_task_security_group_id]
    subnets = var.subnet_ids
  }

  task_definition = aws_ecs_task_definition.web.id

  load_balancer {
    target_group_arn = var.lb_target_group_web_arn
    container_name = "web"
    container_port = 3000
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
    create_before_destroy = true
  }

  force_new_deployment = true

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "web" {
  family = "web"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = "256"
  memory = "512"

  container_definitions = jsonencode([
    {
      name = "web"
      image = var.web_image
      portMappings = [
        {
          containerPort = 3000
          hostPort = 3000
        }
      ]
      environment = [
        {
          name = "NODE_ENV"
          value = var.environment
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = aws_cloudwatch_log_group.web.name
          awslogs-region = var.region_name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn = var.ecs_task_role_arn

  runtime_platform {
    cpu_architecture = "ARM64"
  }

  tags = {
    Environment = var.environment
  }
}