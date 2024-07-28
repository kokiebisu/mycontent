output lambda_generate_blog_arn {
  value = module.generate_blog.lambda_arn
}

output lambda_parse_conversations_arn {
  value = module.parse_conversations.lambda_arn
}
