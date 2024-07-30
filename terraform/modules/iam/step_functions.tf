resource "aws_iam_role" "step_functions_role" {
  name = "step-functions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "step_functions_full_access" {
  role       = aws_iam_role.step_functions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSStepFunctionsFullAccess"
}

resource "aws_iam_role_policy_attachment" "step_functions_lambda_role" {
  role       = aws_iam_role.step_functions_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
}

resource "aws_iam_policy" "cloudwatch_events_policy" {
  name        = "cloudwatch_events_policy"
  description = "Policy for creating CloudWatch managed rules"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "events:PutRule",
          "events:PutTargets",
          "events:DescribeRule",
          "events:EnableRule",
          "events:DisableRule",
          "events:DeleteRule",
          "events:RemoveTargets",
          "ecs:RunTask",
          "iam:PassRole"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_events_policy" {
  role       = aws_iam_role.step_functions_role.name
  policy_arn = aws_iam_policy.cloudwatch_events_policy.arn
}
