resource "aws_cloudwatch_event_target" "sfn_target" {
  rule      = aws_cloudwatch_event_rule.s3_upload_rule.name
  arn       = var.sfn_saga_blog_processor_arn
  role_arn  = var.iam_eventbridge_sfn_role
}

resource "aws_cloudwatch_event_rule" "s3_upload_rule" {
  name        = "capture-s3-upload"
  description = "Capture S3 upload events"
  state       = "ENABLED"

  event_pattern = jsonencode({
    source      = ["aws.s3"]
    detail-type = ["Object Created"]
    detail = {
      bucket = {
        name = [var.upload_bucket_name]
      }
      object = {
        key = [{
          prefix = "conversations/user/"
        }]
      }
      reason = ["PutObject"]
    }
  })
}