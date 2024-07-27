variable services {
  type = list(string)
  description = "The services to deploy"
  default = ["gateway", "service-authentication", "service-blog", "service-user"]
}

variable openai_api_key {
  description = "The API key for the OpenAI API"
  type        = string
}

variable langchain_smith_api_key {
  description = "The API key for the Langchain Smith API"
  type        = string
}
