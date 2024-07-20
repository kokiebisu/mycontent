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

# Create an Application Load Balancer for external access
resource "aws_lb" "external" {
  name               = "external-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.subnet_ids

  tags = {
    Environment = var.environment
  }
}

# Create a service discovery private DNS namespace for internal communication
resource "aws_service_discovery_private_dns_namespace" "internal" {
  name        = "mycontent.internal"
  description = "Internal service discovery namespace"
  vpc         = var.vpc_id
}

module gateway {
  source = "./gateway"
  environment = var.environment
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  alb_security_group_id = var.alb_security_group_id
  ecs_execution_role_arn = var.ecs_execution_role_arn
  ecs_task_role_arn = var.ecs_task_role_arn
}

module service_authentication {
  source = "./service_authentication"
  environment = var.environment
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  alb_security_group_id = var.alb_security_group_id
  ecs_execution_role_arn = var.ecs_execution_role_arn
  ecs_task_role_arn = var.ecs_task_role_arn
}

module service_blog {
  source = "./service_blog"
  environment = var.environment
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  alb_security_group_id = var.alb_security_group_id
  ecs_execution_role_arn = var.ecs_execution_role_arn
  ecs_task_role_arn = var.ecs_task_role_arn
}

module service_user {
  source = "./service_user"
  environment = var.environment
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  alb_security_group_id = var.alb_security_group_id
  ecs_execution_role_arn = var.ecs_execution_role_arn
  ecs_task_role_arn = var.ecs_task_role_arn
}
