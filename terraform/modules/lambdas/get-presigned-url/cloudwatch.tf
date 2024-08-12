resource "aws_cloudwatch_log_group" "parse_conversations" {
  name              = "/aws/lambda/${var.environment}/${aws_lambda_function.get_presigned_url.function_name}"
  retention_in_days = 1
}
