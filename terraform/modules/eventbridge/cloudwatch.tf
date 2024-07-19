resource "aws_cloudwatch_log_group" "eventbridge_log_group" {
  name              = "/aws/events/capture-s3-upload"
  retention_in_days = 14
}