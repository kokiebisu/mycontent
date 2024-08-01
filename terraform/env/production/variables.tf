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