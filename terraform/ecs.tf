# Create an ECS cluster
resource "aws_ecs_cluster" "main" {
  name = local.namespace

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Environment = "production"
  }
}

# Create an Application Load Balancer for external access
resource "aws_lb" "external" {
  name               = "${local.namespace}-external-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = data.aws_subnets.default.ids

  tags = {
    Environment = "production"
  }
}

# Create a service discovery private DNS namespace for internal communication
resource "aws_service_discovery_private_dns_namespace" "internal" {
  name        = "mycontent.internal"
  description = "Internal service discovery namespace"
  vpc         = data.aws_vpc.default.id
}