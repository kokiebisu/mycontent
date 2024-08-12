variable services {
  type = list(string)
  description = "The services to deploy"
  default = ["authentication", "blog", "user"]
}

variable tasks {
  type = list(string)
  description = "The tasks to deploy"
  default = ["generate-blog"]
}

variable lambdas {
  type = list(string)
  description = "The lambdas to deploy"
  default = ["get-presigned-url", "parse-conversations"]
}
