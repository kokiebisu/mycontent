variable subnet_ids {
  type = list(string)
  description = "The subnet ids to deploy to"
}

variable web_image {
  type = string
  description = "The web image to deploy"
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

variable alb_security_group_id {
  type = string
  description = "The security group ID of the ALB"
}

variable cluster_id {
  type = string
  description = "The cluster ID"
}

variable lb_target_group_web_arn {
  type = string
  description = "The ARN of the target group for the web service"
}

variable api_host {
  type = string
  description = "The host of the API"
}
