output ecs_cluster_arn {
  value = aws_ecs_cluster.main.arn
}

output generate_blog_task_definition_arn {
  value = aws_ecs_task_definition.generate_blog.arn
}