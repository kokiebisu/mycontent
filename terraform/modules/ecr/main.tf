module lambdas_ecr {
  source = "./lambdas"

  environment = var.environment
}

module services_ecr {
  source = "./services"

  services = var.services
  environment = var.environment
  namespace = var.namespace
}
