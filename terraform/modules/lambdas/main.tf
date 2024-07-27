module saga_blog_processor {
  source = "./saga_blog_processor"

  lambda_role_arn = aws_iam_role.lambda_role.arn
  environment = var.environment
  region = var.region
  thread_grouper_ecr_repository_url = var.thread_grouper_ecr_repository_url
  process_conversations_ecr_repository_url = var.process_conversations_ecr_repository_url
}
