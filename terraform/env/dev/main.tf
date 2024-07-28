terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.59.0"
    }
  }
}

locals {
  namespace = "mycontent"
  environment = "dev"
}

module "ecs" {
  depends_on = [module.rds]
  source = "../../modules/ecs"
  environment = local.environment
  subnet_ids = data.aws_subnets.default.ids
  region_name = data.aws_region.current.name
  vpc_id = data.aws_vpc.default.id
  service_images = {
    for service in var.services :
    service => try(
      "${data.aws_ecr_repository.services[service].repository_url}:latest",
      "nginx:latest"
    )
  }
  ecs_execution_role_arn = data.aws_iam_role.ecs_execution_role.arn
  ecs_task_role_arn = data.aws_iam_role.ecs_task_role.arn
  ecs_task_security_group_id = data.aws_security_group.ecs_task_security_group.id
  db_host = data.aws_db_instance.rds_db_instance.endpoint
  alb_security_group_id = data.aws_security_group.alb_security_group.id
}

module eventbridge {
  source = "../../modules/eventbridge"

  sfn_saga_blog_processor_arn = module.step_functions.sfn_saga_blog_processor_arn
  upload_bucket_id = data.aws_s3_bucket.upload_bucket.id
  upload_bucket_name = data.aws_s3_bucket.upload_bucket.bucket
}

module lambdas {
  source = "../../modules/lambdas"

  environment = local.environment
  region = data.aws_region.current.name
  parse_conversations_repository_url = data.aws_ecr_repository.parse_conversations.repository_url
  generate_blog_repository_url = data.aws_ecr_repository.generate_blog.repository_url
}

module "rds" {
  source = "../../modules/rds"

  environment = local.environment
  ecs_task_security_group_id = data.aws_security_group.ecs_task_security_group.id
  vpc_id = data.aws_vpc.default.id
}

module step_functions {
  source = "../../modules/step_functions"

  lambda_generate_blog_arn = module.lambdas.lambda_generate_blog_arn
  lambda_parse_conversations_arn = module.lambdas.lambda_parse_conversations_arn
}
