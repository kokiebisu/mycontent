locals {
  service_type = "ecs"
  ecs_services = ["gateway", "service-authentication", "service-blog", "service-user"]
}

# Create ECR repositories for each service
resource "aws_ecr_repository" "ecs_services" {
  for_each = toset(local.ecs_services)

  name                 = "${var.namespace}/${var.environment}/${local.service_type}/${each.key}"
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
      description  = "Keep last 5 images"
      selection = {
        tagStatus     = "any"
        countType     = "imageCountMoreThan"
        countNumber   = 5
      }
      action = {
        type = "expire"
      }
    }]
  })
}
