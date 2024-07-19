output lambda_process_conversations_arn {
  value = module.process_conversations.lambda_arn
}

output lambda_generate_content_arn {
  value = module.generate_content.lambda_arn
}
