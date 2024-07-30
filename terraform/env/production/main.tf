locals {
  namespace = "mycontent"
  environment = "production"
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
  ecs_execution_role_arn = data.aws_iam_role.ecs_execution_role.arn
  ecs_task_role_arn = data.aws_iam_role.ecs_task_role.arn
  ecs_task_security_group_id = data.aws_security_group.ecs_task_security_group.id
  db_host = module.rds.db_host
  alb_security_group_id = data.aws_security_group.alb_security_group.id

  depends_on = [module.rds]
}

module eventbridge {
  source = "../../modules/eventbridge"

  sfn_saga_blog_processor_arn = module.step_functions.sfn_saga_blog_processor_arn
  upload_bucket_id = data.aws_s3_bucket.upload_bucket.id
  upload_bucket_name = data.aws_s3_bucket.upload_bucket.bucket
  iam_eventbridge_sfn_role = data.aws_iam_role.eventbridge_sfn_role.arn

  depends_on = [module.step_functions]
}

module lambdas {
  source = "../../modules/lambdas"

  environment = local.environment
  region = data.aws_region.current.name
  parse_conversations_ecr_repository_url = data.aws_ecr_repository.parse_conversations.repository_url
  lambda_role_arn = data.aws_iam_role.lambda_role.arn
}

module "rds" {
  source = "../../modules/rds"

  environment = local.environment
  ecs_task_security_group_id = data.aws_security_group.ecs_task_security_group.id
  vpc_id = data.aws_vpc.default.id
  rds_security_group_id = data.aws_security_group.rds_security_group.id
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
