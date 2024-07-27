resource "aws_lambda_function" "process_conversations" {
  function_name = "process_conversations"
  role          = var.lambda_role_arn
  package_type  = "Image"
  image_uri     = "${var.ecr_repository_url}:latest"
  timeout       = 300 # 5 minutes
  architectures    = ["arm64"]

  environment {
    variables = {
      OPENAI_API_KEY         = var.openai_api_key
      LANGCHAIN_TRACING_V2   = "true"
      LANGCHAIN_SMITH_API_KEY      = var.langchain_smith_api_key
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}