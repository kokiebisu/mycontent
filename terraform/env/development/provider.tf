terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.59.0"
    }
  }
}

locals {
  region = "ap-northeast-1"
}

provider "aws" {
  region  = local.region
  profile = "mycontent"
}

provider "aws" {
  region = "us-east-1"
  alias = "cloudfront"
  profile = "mycontent"
}
