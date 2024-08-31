terraform {
  required_version = "1.9.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.59.0"
    }
  }
}

locals {
  namespace = "mycontent"
  domain_name = "mycontent.is"
  subject_alternative_names = ["*.${local.domain_name}"]
  environment = "development"
}

module cloudfront {
  source = "../../modules/cloudfront"
  alb_external_dns_name = module.load_balancer.api_host
  environment = local.environment
  route53_zone_id = data.aws_route53_zone.main.zone_id
  domain_name = local.domain_name
  subject_alternative_names = local.subject_alternative_names
  providers = {
    aws.use1 = aws.use1
  }

  depends_on = [module.load_balancer]
}

module dynamodb {
  source = "../../modules/dynamodb"
  environment = local.environment
}

module "ecs" {
  source = "../../modules/ecs"
  environment = local.environment
  subnet_ids = data.aws_subnets.default.ids
  region_name = data.aws_region.current.name
  vpc_id = data.aws_vpc.default.id
  gateway_image = "${data.aws_ecr_repository.gateway.repository_url}:latest"
  service_images = {
    for service in var.services :
    service => try(
      "${data.aws_ecr_repository.services[service].repository_url}:latest"
    )
  }
  task_images = {
    for task in var.tasks :
    task => try(
      "${data.aws_ecr_repository.tasks[task].repository_url}:latest"
    )
  }
  web_image = "${data.aws_ecr_repository.web.repository_url}:latest"
  ecs_execution_role_arn = data.aws_iam_role.ecs_execution_role.arn
  ecs_task_role_arn = data.aws_iam_role.ecs_task_role.arn
  ecs_task_security_group_id = data.aws_security_group.ecs_task_security_group.id
  db_host = module.rds.db_host
  alb_security_group_id = data.aws_security_group.alb_security_group.id
  lb_target_group_gateway_arn = module.load_balancer.lb_target_group_gateway_arn
  lb_target_group_web_arn = module.load_balancer.lb_target_group_web_arn
  api_host = module.load_balancer.api_host
  alb_dns_name = module.load_balancer.api_host

  depends_on = [module.load_balancer, module.rds, module.cloudfront]
}

module eventbridge {
  source = "../../modules/eventbridge"

  environment = local.environment
  sfn_saga_blog_processor_arn = module.step_functions.sfn_saga_blog_processor_arn
  upload_bucket_id = data.aws_s3_bucket.upload_bucket.id
  upload_bucket_name = data.aws_s3_bucket.upload_bucket.bucket
  iam_eventbridge_sfn_role = data.aws_iam_role.eventbridge_sfn_role.arn

  depends_on = [module.step_functions]
}

module lambdas {
  source = "../../modules/lambdas"

  environment = local.environment
  lambda_role_arn = data.aws_iam_role.lambda_role.arn
  lambda_images = {
    for lambda in var.lambdas :
    lambda => try(
      "${data.aws_ecr_repository.lambdas[lambda].repository_url}:latest"
    )
  }
}

module load_balancer {
  source = "../../modules/load_balancer"
  environment = local.environment
  subnet_ids = data.aws_subnets.default.ids
  alb_security_group_id = data.aws_security_group.alb_security_group.id
  vpc_id = data.aws_vpc.default.id
  lambda_get_presigned_url_arn = module.lambdas.get_presigned_url_arn
  domain_name = local.domain_name
  subject_alternative_names = local.subject_alternative_names
  route53_zone_id = data.aws_route53_zone.main.zone_id

  depends_on = [module.lambdas]
}

module "rds" {
  source = "../../modules/rds"

  environment = local.environment
  ecs_task_security_group_id = data.aws_security_group.ecs_task_security_group.id
  vpc_id = data.aws_vpc.default.id
  rds_security_group_id = data.aws_security_group.rds_security_group.id
}

module "route53" {
  source = "../../modules/route53"
  cloudfront_distribution_domain_name = module.cloudfront.cloudfront_distribution_domain_name
  cloudfront_distribution_hosted_zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id

  depends_on = [module.cloudfront]
}

module step_functions {
  source = "../../modules/step_functions"

  iam_role_step_functions_role_arn = data.aws_iam_role.step_functions_role.arn
  lambda_parse_conversations_arn = module.lambdas.lambda_parse_conversations_arn
  ecs_cluster_arn = module.ecs.ecs_cluster_arn
  generate_blog_task_definition_arn = module.ecs.generate_blog_task_definition_arn
  ecs_task_security_group_id = data.aws_security_group.ecs_task_security_group.id
  subnet_ids = data.aws_subnets.default.ids
  environment = local.environment
  region_name = data.aws_region.current.name

  depends_on = [module.lambdas, module.ecs]
}
