resource "aws_cloudwatch_log_group" "thread_grouper" {
  name              = "/aws/lambda/${aws_lambda_function.thread_grouper.function_name}"
  retention_in_days = 14
}
