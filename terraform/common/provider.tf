provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/Environments/aws/.aws/credentials"]
  profile                  = "mycontent"
}
