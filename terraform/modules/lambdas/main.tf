module saga_blog_processor {
  source = "./saga_blog_processor"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
  region = var.region
  parse_conversations_ecr_repository_url = var.parse_conversations_ecr_repository_url
  generate_blog_ecr_repository_url = var.generate_blog_ecr_repository_url
  openai_api_key = var.openai_api_key
  langchain_smith_api_key = var.langchain_smith_api_key
}
