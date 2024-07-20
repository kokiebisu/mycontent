resource "aws_cloudwatch_log_group" "capture_s3_upload" {
  name              = "/aws/events/capture-s3-upload"
  retention_in_days = 14
}