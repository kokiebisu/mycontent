resource "aws_cloudwatch_log_group" "web" {
  name = "/aws/ecs/${var.environment}/web"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}
