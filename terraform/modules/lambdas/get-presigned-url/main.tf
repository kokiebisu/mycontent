resource "aws_lambda_function" "get_presigned_url" {
  function_name = "${var.environment}-get-presigned-url"
  role          = var.lambda_role_arn
  package_type  = "Image" 
  image_uri     = "${var.ecr_repository_url}"
  timeout      = 300
  architectures = ["arm64"]

  lifecycle {
    create_before_destroy = true
  }
}
