resource "aws_lb_target_group" "web" {
  name = "${var.environment}-web-tg"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"

  health_check {
    path = "/health"
    port = 3000
    healthy_threshold = 2
    unhealthy_threshold = 10
    timeout = 30
    interval = 60
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "web" {
  listener_arn = aws_lb_listener.main.arn
  priority = 200

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
