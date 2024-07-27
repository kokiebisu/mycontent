# Create CloudWatch log group for the gateway service
resource "aws_cloudwatch_log_group" "gateway" {
  name              = "/aws/ecs/${var.environment}/gateway"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}