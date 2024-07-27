resource "aws_ecr_repository" "process_conversations" {
  name  = "${var.namespace}/${var.environment}/process_conversations"
  
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}

resource "aws_ecr_repository" "thread_grouper" {
  name  = "${var.namespace}/${var.environment}/thread_grouper"
  
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
  }

  force_delete = true
}
