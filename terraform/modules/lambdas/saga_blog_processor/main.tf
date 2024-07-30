module parse_conversations {
  source = "./parse_conversations"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
  ecr_repository_url = var.parse_conversations_ecr_repository_url
}
