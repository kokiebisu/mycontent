variable subnet_ids {
  type = list(string)
  description = "The subnet ids to deploy to"
}

variable gateway_image {
  type = string
  description = "The gateway image to deploy"
}

variable service_images {
  type = map(string)
  description = "The service images to deploy"
}

variable web_image {
  type = string
  description = "The web image to deploy"
}

variable task_images {
  type = map(string)
  description = "The task images to deploy"
}

variable region_name {
  type = string
  description = "The region to deploy to"
}

variable environment {
  type = string
  description = "The environment to deploy to"
}

variable vpc_id {
  type = string
  description = "The vpc id to deploy to"
}

variable ecs_execution_role_arn {
  type = string
  description = "The ARN of the ECS execution role"
}

variable ecs_task_role_arn {
  type = string
  description = "The ARN of the ECS task role"
}

variable ecs_task_security_group_id {
  type = string
  description = "The security group ID of the ECS task"
}

variable db_host {
  type = string
  description = "The host of the RDS instance"
}

variable alb_security_group_id {
  type = string
  description = "The security group ID of the ALB"
}

variable lb_target_group_gateway_arn {
  type = string
  description = "The ARN of the target group for the gateway"
}

variable lb_target_group_web_arn {
  type = string
  description = "The ARN of the target group for the web service"
}

variable api_host {
  type = string
  description = "The host of the API"
}

variable alb_dns_name {
  type = string
  description = "The DNS name of the ALB"
}
