resource "aws_lambda_function" "process_conversations" {
  function_name = "process_conversations"
  role          = var.lambda_role_arn
  package_type  = "Image"
  image_uri     = "${var.ecr_repository_url}:latest"
  timeout       = 300 # 5 minutes
  architectures    = ["arm64"]

  lifecycle {
    create_before_destroy = true
  }
}