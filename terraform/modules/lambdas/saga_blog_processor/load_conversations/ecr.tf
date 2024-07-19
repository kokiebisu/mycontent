resource "aws_ecr_repository" "load_conversations" {
  count = var.environment == "production" ? 1 : 0
  name  = "load_conversations"
  
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}
