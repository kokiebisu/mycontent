module saga_blog_processor {
  source = "./saga_blog_processor"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
  region = var.region
  thread_grouper_ecr_repository_url = var.thread_grouper_ecr_repository_url
  process_conversations_ecr_repository_url = var.process_conversations_ecr_repository_url
  openai_api_key = var.openai_api_key
  langchain_smith_api_key = var.langchain_smith_api_key
}
