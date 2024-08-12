output alb_external_arn {
  value = aws_lb.external.arn
  description = "The ARN of the ALB"
}

output lb_target_group_gateway_arn {
  value = aws_lb_target_group.gateway.arn
  description = "The ARN of the target group for the gateway"
}
