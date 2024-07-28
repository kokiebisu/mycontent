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

variable generate_blog_ecr_repository_url {
  description = "The URL of the ECR repository for generate_blog"
  type        = string
}

variable openai_api_key {
  description = "The API key for the OpenAI API"
  type        = string
}

variable langchain_smith_api_key {
  description = "The API key for the Langchain Smith API"
  type        = string
}
