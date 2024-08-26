resource "aws_cloudwatch_log_group" "parse_conversations" {
  name              = "/aws/lambda/${var.environment}/parse-conversations"
}
