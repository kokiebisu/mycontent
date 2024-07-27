terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.59.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

locals {
  environments = ["production"]
}

module ecr {
  source   = "../modules/ecr"
  for_each = toset(local.environments)

  environment = each.key
}

module iam {
  source = "../modules/iam"
}

module security_group {
  source = "../modules/security_group"
  for_each = toset(local.environments)

  environment = each.key
  vpc_id = data.aws_vpc.default.id
  vpc_cidr = data.aws_vpc.default.cidr_block

  depends_on = [module.iam]
}

module s3 {
  source = "../modules/s3"

  allowed_origins = ["http://localhost:3000"]
}
