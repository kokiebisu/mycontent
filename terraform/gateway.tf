# Create ECS service for the gateway
resource "aws_ecs_service" "gateway" {
  name             = "gateway"
  cluster          = aws_ecs_cluster.main.id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnets.default.ids
  }

  task_definition = aws_ecs_task_definition.gateway.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.gateway.arn
    container_name   = "gateway"
    container_port   = 4000
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
    create_before_destroy = true
  }

  tags = {
    Environment = "production"
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
      image = local.service_images["gateway"]
      environment = [
        {
          name  = "AUTHENTICATION_SERVICE_URL"
          value = "http://${aws_lb.internal.dns_name}:4001/query"
        },
        {
          name  = "USER_SERVICE_URL"
          value = "http://${aws_lb.internal.dns_name}:4003/query"
        },
        {
          name  = "BLOG_SERVICE_URL"
          value = "http://${aws_lb.internal.dns_name}:4002/query"
        },
        {
          name = "GRAPHQL_PORT",
          value = "4000"
        },
        {
          name = "USER_GRPC_PORT",
          value = "50053"
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
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  runtime_platform {
    cpu_architecture = "X86_64"
  } 

  tags = {
    Environment = "production"
  }
}

# Create CloudWatch log group for the gateway service
resource "aws_cloudwatch_log_group" "gateway" {
  name              = "/ecs/${local.namespace}/gateway"
  retention_in_days = 30

  tags = {
    Environment = "production"
  }
}


# Create a target group for the gateway service
resource "aws_lb_target_group" "gateway" {
  name        = "${local.namespace}-gateway-tg"
  port        = 4000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    path                = "/health"
    port                = 4000
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 30
    interval            = 60
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create a listener for the ALB
resource "aws_lb_listener" "gateway" {
  load_balancer_arn = aws_lb.external.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = "200"
    }
  }

  lifecycle {
    ignore_changes = [default_action]
  }
}

# Create a listener rule to associate the listener with the target group
resource "aws_lb_listener_rule" "gateway" {
  listener_arn = aws_lb_listener.gateway.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gateway.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
