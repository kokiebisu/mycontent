module get_presigned_url {
  source = "./get-presigned-url"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
  ecr_repository_url = var.lambda_images["get-presigned-url"]
}

module parse_conversations {
  source = "./parse_conversations"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
  ecr_repository_url = var.lambda_images["parse-conversations"]
}
