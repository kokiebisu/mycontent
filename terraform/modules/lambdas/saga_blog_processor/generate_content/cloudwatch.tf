resource "aws_cloudwatch_log_group" "generate_content" {
  name              = "/aws/lambda/${aws_lambda_function.generate_content.function_name}"
  retention_in_days = 14
}
