variable environment {
  description = "The deployment environment (dev or production)"
  type        = string
}

variable use_ecr_image {
  description = "Whether to use an ECR image or the public Lambda Python runtime"
  type        = bool
  default     = false
}

variable lambda_role_arn {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable ecr_repository_url {
  description = "The URL of the ECR repository"
  type        = string
}
