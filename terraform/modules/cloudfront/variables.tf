variable "alb_external_dns_name" {
  type = string
  description = "The external DNS name of the ALB"
}

variable "environment" {
  type = string
  description = "The environment of the deployment"
}

variable "route53_zone_id" {
  type = string
  description = "The ID of the Route53 zone"
}

variable "acm_certificate_arn" {
  type = string
  description = "The ARN of the ACM certificate"
}
