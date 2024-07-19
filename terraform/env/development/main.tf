module s3 {
  source = "../../modules/s3"

  allowed_origins = ["http://localhost:3000"]
}

module lambdas {
  source = "../../modules/lambdas"

  environment = "dev" # we have this to push to local registry
}

module step_functions {
  source = "../../modules/step_functions"

  lambda_process_conversations_arn = module.lambdas.lambda_process_conversations_arn
  lambda_generate_content_arn = module.lambdas.lambda_generate_content_arn
}
