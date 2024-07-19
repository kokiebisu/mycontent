terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.59.0"
    }
  }
}

module s3 {
  source = "../../modules/s3"

  allowed_origins = ["http://localhost:3000"]
}

module eventbridge {
  source = "../../modules/eventbridge"

  sfn_saga_blog_processor_arn = module.step_functions.sfn_saga_blog_processor_arn
  upload_bucket_id = module.s3.upload_bucket_id
  upload_bucket_name = module.s3.upload_bucket_name
}

module lambdas {
  source = "../../modules/lambdas"

  environment = "dev"
}

module step_functions {
  source = "../../modules/step_functions"

  lambda_process_conversations_arn = module.lambdas.lambda_process_conversations_arn
  lambda_generate_content_arn = module.lambdas.lambda_generate_content_arn
}
