resource "aws_ecr_repository" "generate_content" {
  count = var.environment == "production" ? 1 : 0
  name  = "generate_content"
  
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}
