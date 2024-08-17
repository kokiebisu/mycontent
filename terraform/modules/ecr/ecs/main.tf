locals {
  service_type = "ecs"
  ecs_services = ["authentication", "blog", "user"]
  ecs_tasks = ["generate-blog"]
}

resource "aws_ecr_repository" "ecs_gateway" {
  name                 = "${var.namespace}/${var.environment}/ecs/gateway"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}

resource "aws_ecr_repository" "ecs_services" {
  for_each = toset(local.ecs_services)

  name                 = "${var.namespace}/${var.environment}/ecs/service/${each.key}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}

resource aws_ecr_repository "ecs_tasks" {
  for_each = toset(local.ecs_tasks)

  name                 = "${var.namespace}/${var.environment}/ecs/task/${each.key}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}

resource "aws_ecr_repository" "ecs_web" {
  name                 = "${var.namespace}/${var.environment}/ecs/web"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}

# Set up lifecycle policy for ECR repositories
resource "aws_ecr_lifecycle_policy" "services_policy" {
  for_each   = aws_ecr_repository.ecs_services

  repository = each.value.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 2 images"
      selection = {
        tagStatus     = "any"
        countType     = "imageCountMoreThan"
        countNumber   = 2
      }
      action = {
        type = "expire"
      }
    }]
  })
}
