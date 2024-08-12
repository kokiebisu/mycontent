variable environment {
  type = string
  description = "The environment to deploy to"
}

variable lambda_images {
  type = map(string)
  description = "The images for the lambdas"
}

variable lambda_role_arn {
  type = string
  description = "The ARN of the role for the Lambda function"
}
