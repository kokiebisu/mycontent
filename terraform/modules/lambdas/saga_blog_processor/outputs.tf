output lambda_process_conversations_arn {
  value = module.process_conversations.lambda_arn
}

output lambda_thread_grouper_arn {
  value = module.thread_grouper.lambda_arn
}
