locals {
  image_uri = var.environment == "dev" ? "localhost:5001/load_conversations:latest" : "${aws_ecr_repository.load_conversations[0].repository_url}:latest"
}

resource "aws_lambda_function" "load_conversations" {
  function_name = "load_conversations"
  role          =  var.lambda_role_arn
  package_type  = "Image"
  image_uri     = local.image_uri
  
  dynamic "image_config" {
    for_each = var.environment == "dev" ? [1] : []
    content {
      entry_point = ["python", "-m", "awslambdaric"]
      command     = ["load_conversations.lambda_handler"]
    }
  }
}
