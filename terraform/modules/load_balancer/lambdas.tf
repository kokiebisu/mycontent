resource "aws_lb_target_group" "lambda" {
  name = "lambda"
  target_type = "lambda"
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    enabled             = true
    path                = "/health"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "get_presigned_url" {
  target_group_arn = aws_lb_target_group.lambda.arn
  target_id        = var.lambda_get_presigned_url_arn
}
