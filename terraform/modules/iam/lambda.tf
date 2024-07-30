resource "aws_iam_role" "lambda_role" {
  name  = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "parse_conversations_lambda" {
  name        = "parse-conversations-lambda"
  description = "IAM policy for parse conversations lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem"
        ]
        Resource = "arn:aws:dynamodb:us-east-1:${var.account_id}:table/${var.environment}-conversation-store"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "parse_conversations_lambda" {
  policy_arn = aws_iam_policy.parse_conversations_lambda.arn
  role       = aws_iam_role.lambda_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_iam_role_policy_attachment" "s3_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.lambda_role.name
}
