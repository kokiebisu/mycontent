resource "aws_lb_target_group" "gateway" {
  name        = "${var.environment}-gateway-tg"
  port        = 4000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/health"
    port                = 4000
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 30
    interval            = 60
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "gateway" {
  listener_arn = aws_lb_listener.main.arn
  priority = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gateway.arn
  }

  condition {
    path_pattern {
      values = ["/api"]
    }
  }
}
