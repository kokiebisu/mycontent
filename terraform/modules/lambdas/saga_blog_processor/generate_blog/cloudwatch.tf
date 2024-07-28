resource "aws_cloudwatch_log_group" "generate_blog" {
  name              = "/aws/lambda/${aws_lambda_function.generate_blog.function_name}"
  retention_in_days = 14
}