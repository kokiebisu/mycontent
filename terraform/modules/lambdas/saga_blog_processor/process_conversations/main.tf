locals {
  lambda_path = "../../../packages/saga-blog-processor/process-conversations"
}

data "archive_file" "process_conversations" {
  type        = "zip"
  source_dir  = local.lambda_path
  output_path = "${local.lambda_path}/lambda_function.zip"
}

resource "aws_lambda_function" "process_conversations" {
  function_name    = "process_conversations"
  role             = var.lambda_role_arn
  filename         = data.archive_file.process_conversations.output_path
  source_code_hash = data.archive_file.process_conversations.output_base64sha256
  handler          = "main.lambda_handler"
  runtime          = "python3.8"

  depends_on = [data.archive_file.process_conversations]
}
