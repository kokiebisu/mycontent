resource "aws_cloudwatch_log_group" "get_presigned_url" {
  name              = "/aws/lambda/${var.environment}/get-presigned-url"
  retention_in_days = 1
}
