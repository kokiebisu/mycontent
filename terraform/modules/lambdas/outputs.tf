output lambda_process_conversations_arn {
  value = module.saga_blog_processor.lambda_process_conversations_arn
}

output lambda_generate_content_arn {
  value = module.saga_blog_processor.lambda_generate_content_arn
}
