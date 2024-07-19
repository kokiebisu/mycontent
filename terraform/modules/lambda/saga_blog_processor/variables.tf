variable environment {
  description = "The deployment environment (dev or production)"
  type        = string
}

variable lambda_role_arn {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}
