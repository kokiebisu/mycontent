resource "aws_cloudwatch_log_group" "process_conversations" {
  name              = "/aws/lambda/${aws_lambda_function.process_conversations.function_name}"
  retention_in_days = 14
}