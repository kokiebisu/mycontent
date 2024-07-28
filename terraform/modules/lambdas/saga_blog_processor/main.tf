module parse_conversations {
  source = "./parse_conversations"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
  ecr_repository_url = var.parse_conversations_ecr_repository_url
}

module generate_blog {
  source = "./generate_blog"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
  ecr_repository_url = var.generate_blog_ecr_repository_url
  openai_api_key = var.openai_api_key
  langchain_smith_api_key = var.langchain_smith_api_key
}
