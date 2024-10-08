# Create an ECS cluster
resource "aws_ecs_cluster" "main" {
  name = "cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Environment = var.environment
  }
}

module gateway {
  source = "./gateway"
  environment = var.environment
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  alb_security_group_id = var.alb_security_group_id
  ecs_execution_role_arn = var.ecs_execution_role_arn
  ecs_task_role_arn = var.ecs_task_role_arn
  db_host = var.db_host
  region_name = var.region_name
  ecs_task_security_group_id = var.ecs_task_security_group_id
  service_image = var.gateway_image
  private_dns_namespace_id = aws_service_discovery_private_dns_namespace.internal.id
  cluster_id = aws_ecs_cluster.main.id
  lb_target_group_gateway_arn = var.lb_target_group_gateway_arn
  cors_origin = var.alb_dns_name
}

module service_authentication {
  source = "./service_authentication"
  environment = var.environment
  vpc_id = var.vpc_id
  db_host = var.db_host
  subnet_ids = var.subnet_ids
  region_name = var.region_name
  service_image = var.service_images["authentication"]
  alb_security_group_id = var.alb_security_group_id
  ecs_execution_role_arn = var.ecs_execution_role_arn
  ecs_task_role_arn = var.ecs_task_role_arn
  ecs_task_security_group_id = var.ecs_task_security_group_id
  private_dns_namespace_id = aws_service_discovery_private_dns_namespace.internal.id
  cluster_id = aws_ecs_cluster.main.id
}

module service_blog {
  source = "./service_blog"
  environment = var.environment
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  alb_security_group_id = var.alb_security_group_id
  ecs_execution_role_arn = var.ecs_execution_role_arn
  ecs_task_role_arn = var.ecs_task_role_arn
  ecs_task_security_group_id = var.ecs_task_security_group_id
  service_image = var.service_images["blog"]
  db_host = var.db_host
  region_name = var.region_name
  private_dns_namespace_id = aws_service_discovery_private_dns_namespace.internal.id
  cluster_id = aws_ecs_cluster.main.id
}

module service_user {
  source = "./service_user"
  environment = var.environment
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  alb_security_group_id = var.alb_security_group_id
  ecs_execution_role_arn = var.ecs_execution_role_arn
  ecs_task_role_arn = var.ecs_task_role_arn
  ecs_task_security_group_id = var.ecs_task_security_group_id
  service_image = var.service_images["user"]
  db_host = var.db_host
  region_name = var.region_name
  private_dns_namespace_id = aws_service_discovery_private_dns_namespace.internal.id
  cluster_id = aws_ecs_cluster.main.id
}

module web {
  source = "./web"
  environment = var.environment
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  alb_security_group_id = var.alb_security_group_id
  ecs_execution_role_arn = var.ecs_execution_role_arn
  ecs_task_role_arn = var.ecs_task_role_arn
  ecs_task_security_group_id = var.ecs_task_security_group_id
  web_image = var.web_image
  region_name = var.region_name
  cluster_id = aws_ecs_cluster.main.id
  lb_target_group_web_arn = var.lb_target_group_web_arn
  api_host = var.api_host
}

# Create a service discovery private DNS namespace for internal communication
resource "aws_service_discovery_private_dns_namespace" "internal" {
  name        = "mycontent.internal"
  description = "Internal service discovery namespace"
  vpc         = var.vpc_id
}

resource "aws_ecs_task_definition" "generate_blog" {
  family                   = "${var.environment}-generate-blog"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "generate-blog"
      image     = var.task_images["generate-blog"]
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.saga_blog_processor_generate_blog.name
          awslogs-region        = var.region_name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  runtime_platform {
    cpu_architecture = "ARM64"
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "saga_blog_processor_generate_blog" {
  name              = "/aws/ecs/${var.environment}/saga-blog-processor/generate-blog"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}
