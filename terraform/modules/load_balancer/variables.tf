variable alb_security_group_id {
  type = string
  description = "The security group ID for the ALB"
}

variable subnet_ids {
  type = list(string)
  description = "The subnet IDs for the ALB"
}

variable environment {
  type = string
  description = "The environment for the ALB"
}

variable vpc_id {
  type = string
  description = "The VPC ID for the ALB"
}

variable lambda_get_presigned_url_arn {
  type = string
  description = "The ARN of the get presigned URL lambda function"
}

variable domain_name {
  type = string
  description = "The domain name for the ALB"
}

variable route53_zone_id {
  type = string
  description = "The Route53 zone ID for the domain name"
}
