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

variable thread_grouper_ecr_repository_url {
  description = "The URL of the ECR repository for thread_grouper"
  type        = string
}

variable process_conversations_ecr_repository_url {
  description = "The URL of the ECR repository for process_conversations"
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
