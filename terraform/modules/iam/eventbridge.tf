resource "aws_iam_role" "eventbridge_sfn_role" {
  name = "eventbridge-sfn-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eventbridge_sfn_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AWSStepFunctionsFullAccess"
  role       = aws_iam_role.eventbridge_sfn_role.name
}

resource "aws_iam_role_policy_attachment" "eventbridge_s3_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.eventbridge_sfn_role.name
}

resource "aws_iam_role_policy" "eventbridge_sfn_execution_policy" {
  name = "eventbridge_sfn_execution_policy"
  role = aws_iam_role.eventbridge_sfn_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "states:StartExecution"
        ]
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.upload_bucket_name}",
          "arn:aws:s3:::${var.upload_bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eventbridge_cloudwatch_logs_policy" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role       = aws_iam_role.eventbridge_sfn_role.name
}
