module process_conversations {
  source = "./process_conversations"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
}

module generate_content {
  source = "./generate_content"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
}
