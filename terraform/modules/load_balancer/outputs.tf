output alb_external_arn {
  value = aws_lb.external.arn
  description = "The ARN of the ALB"
}

output lb_target_group_gateway_arn {
  value = aws_lb_target_group.gateway.arn
  description = "The ARN of the target group for the gateway"
}

output lb_target_group_web_arn {
  value = aws_lb_target_group.web.arn
  description = "The ARN of the target group for the web"
}

output api_host {
  value = aws_lb.external.dns_name
  description = "The host of the API"
}
