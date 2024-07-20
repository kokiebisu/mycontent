locals {
  lambda_path = "../../../packages/saga-blog-processor/process-conversations"
}

resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Activating Python environment..."
      eval "$(pyenv init -)"
      pyenv shell process-conversations
      echo "Creating dist directory..."
      mkdir -p ${local.lambda_path}/dist
      echo "Installing dependencies..."
      pip install --platform manylinux2014_x86_64 --target=${local.lambda_path}/dist --implementation cp --python-version 3.11 --only-binary=:all: --upgrade -r ${local.lambda_path}/requirements.txt
      echo "Copying Python files..."
      cp ${local.lambda_path}/*.py ${local.lambda_path}/dist/
      echo "Listing dist contents:"
      ls -R ${local.lambda_path}/dist
    EOT
  }

  triggers = {
    dependencies_versions = filemd5("${local.lambda_path}/requirements.txt")
    source_code_hash      = filemd5("${local.lambda_path}/main.py")
  }
}

data "archive_file" "process_conversations" {
  type        = "zip"
  source_dir  = "${local.lambda_path}/dist"
  output_path = "${local.lambda_path}/lambda_function.zip"
  excludes    = ["*.pyc", "__pycache__"]
  depends_on  = [null_resource.install_dependencies]
}

resource "aws_lambda_function" "process_conversations" {
  function_name    = "process_conversations"
  role             = var.lambda_role_arn
  filename         = data.archive_file.process_conversations.output_path
  source_code_hash = data.archive_file.process_conversations.output_base64sha256
  handler          = "main.lambda_handler"
  runtime          = "python3.11"
  timeout          = 300  # 5 minutes

  depends_on = [data.archive_file.process_conversations]

  lifecycle {
    create_before_destroy = true
  }
}
