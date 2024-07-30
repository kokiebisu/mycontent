variable environment {
  type = string
  description = "The environment to deploy to"
}

variable region {
  type = string
  description = "The region to deploy to"
}

variable parse_conversations_ecr_repository_url {
  type = string
  description = "The repository URL for the thread grouper"
}

variable lambda_role_arn {
  type = string
  description = "The ARN of the role for the Lambda function"
}
