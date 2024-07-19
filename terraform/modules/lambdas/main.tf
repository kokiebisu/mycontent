module saga_blog_processor {
  source = "./saga_blog_processor"

  lambda_role_arn = aws_iam_role.lambda_role.arn
  environment = var.environment
}
