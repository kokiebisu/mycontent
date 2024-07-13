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

# Create an Application Load Balancer
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

# Create an internal ALB
resource "aws_lb" "internal" {
  name               = "${local.namespace}-internal-alb"
  internal           = true
  load_balancer_type = "network"
  security_groups    = [aws_security_group.internal_alb.id]
  subnets            = data.aws_subnets.default.ids

  tags = {
    Environment = "production"
  }
}
