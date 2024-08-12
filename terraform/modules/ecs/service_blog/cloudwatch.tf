resource "aws_cloudwatch_log_group" "service_blog" {
  name              = "/aws/ecs/${var.environment}/service/blog"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}
