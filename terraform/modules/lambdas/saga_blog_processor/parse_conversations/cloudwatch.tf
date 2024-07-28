resource "aws_cloudwatch_log_group" "parse_conversations" {
  name              = "/aws/lambda/${aws_lambda_function.parse_conversations.function_name}"
  retention_in_days = 14
}
