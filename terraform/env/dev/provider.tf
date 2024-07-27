provider "aws" {
  region  = "us-east-1"
  profile = "mycontent"

  # access_key = "test"
  # secret_key = "test"
  # s3_use_path_style           = true
  # skip_credentials_validation = true
  # skip_metadata_api_check     = true
  # skip_requesting_account_id  = true

  # endpoints {
  #   s3             = "http://localhost:4566"
  #   lambda         = "http://localhost:4566"
  #   iam    = "http://localhost:4566"
  #   cloudwatch = "http://localhost:4566"
  #   cloudwatchlogs = "http://localhost:4566"
  #   stepfunctions  = "http://localhost:4566"
  #   events = "http://localhost:4566"
  #   ecr = "http://localhost:5001"
  # }
}
