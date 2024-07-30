variable iam_role_step_functions_role_arn {
  type = string
}

variable lambda_parse_conversations_arn {
  type = string
}

variable ecs_cluster_arn {
  type = string
}

variable generate_blog_task_definition_arn {
  type = string
}

variable ecs_task_security_group_id {
  type = string
}

variable subnet_ids {
  type = list(string)
}

variable region_name {
  type = string
}
