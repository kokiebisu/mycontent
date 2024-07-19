resource "aws_ecr_repository" "process_conversations" {
  count = var.environment == "dev" ? 0 : 1
  name  = "process_conversations"
  
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}