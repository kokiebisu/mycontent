module "ecr" {
  source = "../../modules/ecr"
  environment = "dev"
}

module "ecs" {
  depends_on = [module.iam, module.rds, module.security_group, module.ecr]
  source = "../../modules/ecs"
  environment = "dev"
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
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
  ecs_task_role_arn = module.iam.ecs_task_role_arn
  ecs_task_security_group_id = module.security_group.ecs_task_security_group_id
  db_host = module.rds.db_host
  alb_security_group_id = module.security_group.alb_security_group_id
}

module "iam" {
  source = "../../modules/iam"
  environment = "dev"
}

module "rds" {
  depends_on = [module.iam, module.security_group]
  source = "../../modules/rds"
  environment = "dev"
  ecs_task_security_group_id = module.security_group.ecs_task_security_group_id
  vpc_id = data.aws_vpc.default.id
}

module "security_group" {
  depends_on = [module.iam]
  source = "../../modules/security_group"
  environment = "dev"
  vpc_id = data.aws_vpc.default.id
  vpc_cidr = data.aws_vpc.default.cidr_block
}