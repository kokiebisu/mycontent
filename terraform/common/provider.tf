provider "aws" {
  region = local.region
  shared_credentials_files = ["~/Environments/aws/.aws/credentials"]
  profile                  = "mycontent"
}
