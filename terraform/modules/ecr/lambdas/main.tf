locals {
  service_type = "lambda"
  lambda_services = ["parse-conversations"]
}

resource "aws_ecr_repository" "parse_conversations" {
  for_each = toset(local.lambda_services)
  name  = "${var.namespace}/${var.environment}/${local.service_type}/${each.key}"
  
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}
