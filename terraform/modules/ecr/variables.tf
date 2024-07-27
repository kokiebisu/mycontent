variable environment {
  description = "The environment to deploy to"
  type = string
}

variable services {
  type = list(string)
  description = "The services to deploy"
  default = ["gateway", "service-authentication", "service-blog", "service-user"]
}

variable namespace {
  description = "The namespace to deploy to"
  type = string
  default = "mycontent"
}
