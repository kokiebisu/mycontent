provider "aws" {
  region = "ap-northeast-1"
  shared_credentials_files = ["~/Environments/aws/.aws/credentials"]
  profile                  = "mycontent"
}
