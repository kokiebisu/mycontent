module thread_grouper {
  source = "./thread_grouper"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
  ecr_repository_url = var.thread_grouper_ecr_repository_url
}

module process_conversations {
  source = "./process_conversations"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
  ecr_repository_url = var.process_conversations_ecr_repository_url
  openai_api_key = var.openai_api_key
  langchain_smith_api_key = var.langchain_smith_api_key
}
