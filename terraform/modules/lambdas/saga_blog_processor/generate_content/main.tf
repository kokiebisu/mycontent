locals {
  lambda_path = "../../../packages/saga-blog-processor/generate-content"
}

data "archive_file" "generate_content" {
  type = "zip"
  source_dir = local.lambda_path
  output_path = "${local.lambda_path}/lambda_function.zip"
}

resource "aws_lambda_function" "generate_content" {
  function_name = "generate_content"
  role = var.lambda_role_arn
  filename = data.archive_file.generate_content.output_path
  source_code_hash = data.archive_file.generate_content.output_base64sha256
  handler = "main.lambda_handler"
  runtime = "python3.11"

  depends_on = [data.archive_file.generate_content]

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_lambda_function" "generate_content" {
#    function_name = "generate_content"
#   role          =  var.lambda_role_arn
#   package_type  = "Image"
#   image_uri     = local.image_uri
  
#   dynamic "image_config" {
#     for_each = var.environment == "dev" ? [1] : []
#     content {
#       entry_point = ["python", "-m", "awslambdaric"]
#       command     = ["main.lambda_handler"]
#     }
#   }
# }
