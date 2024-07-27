
resource "aws_cloudwatch_log_group" "service_authentication" {
  name              = "/aws/ecs/${var.environment}/service-authentication"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}
