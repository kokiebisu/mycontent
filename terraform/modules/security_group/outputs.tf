output ecs_task_security_group_id {
  value       = aws_security_group.ecs_tasks.id
  description = "The security group ID of the ECS task"
}

output alb_security_group_id {
  value       = aws_security_group.alb.id
  description = "The security group ID of the ALB"
}
