# Start Generation Here
resource "aws_ssm_parameter" "langchain_api_key" {
  name        = "/secrets/langchain/api_key"
  type        = "SecureString"
  value       = var.langchain_smith_api_key
  description = "API key for Langchain"
}

resource "aws_ssm_parameter" "openai_api_key" {
  name        = "/secrets/openai/api_key"
  type        = "SecureString"
  value       = var.openai_api_key
  description = "API key for OpenAI"
}
