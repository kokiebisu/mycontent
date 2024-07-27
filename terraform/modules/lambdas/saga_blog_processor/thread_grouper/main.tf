resource "aws_lambda_function" "thread_grouper" {
  function_name = "thread_grouper"
  role          = var.lambda_role_arn
  package_type  = "Image" 
  image_uri     = "${var.ecr_repository_url}:latest"
  timeout      = 300
  architectures = ["arm64"]

  lifecycle {
    create_before_destroy = true
  }
}
