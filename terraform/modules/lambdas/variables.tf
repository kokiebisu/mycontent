variable environment {
  type = string
  description = "The environment to deploy to"
}

variable region {
  type = string
  description = "The region to deploy to"
}

variable thread_grouper_ecr_repository_url {
  type = string
  description = "The repository URL for the thread grouper"
}

variable process_conversations_ecr_repository_url {
  type = string
  description = "The repository URL for the process conversations"
}

variable openai_api_key {
  type = string
  description = "The API key for the OpenAI API"
}

variable langchain_smith_api_key {
  type = string
  description = "The API key for the Langchain Smith API"
}

variable lambda_role_arn {
  type = string
  description = "The ARN of the role for the Lambda function"
}
