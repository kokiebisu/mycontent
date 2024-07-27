variable environment {
  type = string
  description = "The environment to deploy to"
}

variable region {
  type = string
  description = "The region to deploy to"
}

variable thread_grouper_ecr_repository_url {
  type = string
  description = "The repository URL for the thread grouper"
}

variable process_conversations_ecr_repository_url {
  type = string
  description = "The repository URL for the process conversations"
}
