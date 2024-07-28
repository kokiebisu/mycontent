module lambdas {
  source = "./lambdas"

  environment = var.environment
  namespace = var.namespace
}

module ecs {
  source = "./ecs"

  environment = var.environment
  namespace = var.namespace
}
