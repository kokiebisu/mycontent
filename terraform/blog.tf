# Create ECS service for the blog service
resource "aws_ecs_service" "blog" {
  name             = "blog"
  cluster          = aws_ecs_cluster.main.id
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = data.aws_subnets.default.ids
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blog_graphql.arn
    container_name   = "service-blog"
    container_port   = 4002
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blog_grpc.arn
    container_name   = "service-blog"
    container_port   = 50052
  }

  task_definition = aws_ecs_task_definition.blog.arn

  lifecycle {
    ignore_changes = [task_definition, desired_count]
    create_before_destroy = true
  }

  tags = {
    Environment = "production"
  }
}

# Create task definition for the blog service
resource "aws_ecs_task_definition" "blog" {
  family                   = "blog"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "service-blog"
      image = local.service_images["service-blog"]
      portMappings = [
        {
          containerPort = 4002
          hostPort      = 4002
        },
        {
          containerPort = 50052
          hostPort      = 50052
        }
      ]
      environment = [
        {
          name = "GRAPHQL_PORT",
          value = "4002"
        },
        {
          name = "BLOG_GRPC_PORT",
          value = "50052"
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
          awslogs-group         = aws_cloudwatch_log_group.blog.name
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

resource "aws_cloudwatch_log_group" "blog" {
  name              = "/ecs/${local.namespace}/blog"
  retention_in_days = 30

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "blog_graphql" {
  name        = "${local.namespace}-blog-graphql-tg"
  port        = 4002
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    protocol = "HTTP"
    path = "/playground"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 30
    interval            = 60
  }
}

resource "aws_lb_target_group" "blog_grpc" {
  name        = "${local.namespace}-blog-grpc-tg"
  port        = 50052
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    protocol = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 30
    interval            = 60
  }
}

resource "aws_lb_listener" "blog_graphql" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "4002"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blog_graphql.arn
  }
}

resource "aws_lb_listener" "blog_grpc" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "50052"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blog_grpc.arn
  }
}
