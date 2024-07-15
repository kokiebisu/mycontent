variable services {
  type = list(string)
  description = "The services to deploy"
  default = ["gateway", "service-authentication", "service-blog", "service-user"]
}
