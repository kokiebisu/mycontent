variable environment {
  type = string
  description = "The environment to deploy to"
}

variable ecs_task_security_group_id {
  type = string
  description = "The security group ID of the ECS task"
}

variable vpc_id {
  type = string
  description = "The VPC ID to deploy to"
}

variable rds_security_group_id {
  type = string
  description = "The security group ID of the RDS instance"
}
