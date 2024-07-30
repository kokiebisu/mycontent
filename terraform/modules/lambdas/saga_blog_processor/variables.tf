variable environment {
  description = "The deployment environment (dev or production)"
  type        = string
}

variable lambda_role_arn {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable region {
  description = "The region of the ECR repository"
  type        = string
}

variable parse_conversations_ecr_repository_url {
  description = "The URL of the ECR repository for parse_conversations"
  type        = string
}
