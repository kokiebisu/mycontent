module s3 {
  source = "../../modules/s3"

  allowed_origins = ["http://localhost:3000"]
}

module lambdas {
  source = "../../modules/lambdas"

  environment = "dev"
}
