terraform {
  required_version = "1.9.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

locals {
  environments = ["development"]
  domain_name = "mycontent.is"
  region = "ap-northeast-1"
}

module ecr {
  source   = "../modules/ecr"
  for_each = toset(local.environments)

  environment = each.key
}

module iam {
  source = "../modules/iam"
  for_each = toset(local.environments)

  upload_bucket_name = module.s3.upload_bucket_name
  vpc_id = data.aws_vpc.default.id
  environment = each.key
  region = local.region
  account_id = data.aws_caller_identity.current.account_id

  depends_on = [module.s3]
}

module security_group {
  source = "../modules/security_group"
  for_each = toset(local.environments)

  environment = each.key
  vpc_id = data.aws_vpc.default.id
  vpc_cidr = data.aws_vpc.default.cidr_block
}

module s3 {
  source = "../modules/s3"

  allowed_origins = ["http://localhost:3000", "https://${local.domain_name}", "https://www.${local.domain_name}"]
}

module ssm {
  source = "../modules/ssm"

  langchain_smith_api_key = var.langchain_smith_api_key
  openai_api_key = var.openai_api_key
}