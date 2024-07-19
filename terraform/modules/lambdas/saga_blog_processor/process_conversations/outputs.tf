output "lambda_arn" {
  # value = var.environment == "dev" ? aws_lambda_function.process_conversations_zip[0].arn : aws_lambda_function.process_conversations_container[0].arn
  value = aws_lambda_function.process_conversations.arn
}
