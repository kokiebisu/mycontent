resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_ssm" {
  name        = "ecs-task-generate-blog"
  description = "Policy to allow SSM GetParameter action for specific parameters"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "ssm:GetParameter"
        Effect   = "Allow"
        Resource = [
          "arn:aws:ssm:*:*:parameter/secrets/openai/api_key",
          "arn:aws:ssm:*:*:parameter/secrets/langchain/api_key"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_s3_full_access_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_ssm_full_access" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_dynamodb_full_access" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}