module load_conversations {
  source = "./load_conversations"

  lambda_role_arn = var.lambda_role_arn
  environment = var.environment
}
