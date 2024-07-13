# Create ECS service for the authentication service
resource "aws_ecs_service" "authentication" {
  name             = "authentication"
  cluster          = aws_ecs_cluster.main.id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnets.default.ids
  }

  task_definition = aws_ecs_task_definition.authentication.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.authentication.arn
    container_name   = "service-authentication"
    container_port   = 4001
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
    create_before_destroy = true
  }

  tags = {
    Environment = "production"
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
      image = local.service_images["service-authentication"]
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
          name = "USER_SERVICE_URL",
          value = "${aws_lb.internal.dns_name}:4003"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.authentication.name
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

resource "aws_cloudwatch_log_group" "authentication" {
  name              = "/ecs/${local.namespace}/authentication"
  retention_in_days = 30

  tags = {
    Environment = "production"
  }
}

# Create target groups for each service
resource "aws_lb_target_group" "authentication" {
  name        = "${local.namespace}-auth-tg"
  port        = 4001
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    path                = "/playground"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 30
    interval            = 60
  }
}

resource "aws_lb_listener" "authentication" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "4001"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.authentication.arn
  }
}

