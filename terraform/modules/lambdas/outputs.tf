output lambda_parse_conversations_arn {
  value = module.parse_conversations.lambda_arn
}

output get_presigned_url_arn {
  value = module.get_presigned_url.lambda_arn
}
