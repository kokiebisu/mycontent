resource "aws_cloudwatch_log_group" "capture_s3_upload" {
  name              = "/aws/eventbridge/${var.environment}/capture-s3-upload"
  retention_in_days = 1
}
