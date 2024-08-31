locals {
  region = "ap-northeast-1"
}

provider "aws" {
  alias = "apn1"
  region  = local.region
  profile = "mycontent"
}

provider "aws" {
  alias = "use1"
  region = "us-east-1"
  profile = "mycontent"
}
