resource "aws_cloudwatch_log_group" "service_user" {
  name              = "/aws/ecs/${var.environment}/service/user"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}
