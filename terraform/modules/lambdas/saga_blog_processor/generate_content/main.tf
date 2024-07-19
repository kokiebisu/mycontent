locals {
  image_uri = var.environment == "dev" ? "localhost:5001/generate_content:latest" : "${aws_ecr_repository.generate_content[0].repository_url}:latest"
}

resource "aws_lambda_function" "generate_content" {
   function_name = "generate_content"
  role          =  var.lambda_role_arn
  package_type  = "Image"
  image_uri     = local.image_uri
  
  dynamic "image_config" {
    for_each = var.environment == "dev" ? [1] : []
    content {
      entry_point = ["python", "-m", "awslambdaric"]
      command     = ["generate_content.lambda_handler"]
    }
  }
}
