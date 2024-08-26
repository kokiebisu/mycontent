provider "aws" {
  region = local.region
  shared_credentials_files = ["~/Environments/aws/.aws/credentials"]
  profile                  = "mycontent"
}

provider "aws" {
  region = "us-east-1"
  alias = "cloudfront"
  profile = "mycontent"
}
