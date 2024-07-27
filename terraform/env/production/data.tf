# Data source to get default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source to get default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Add this data source at the top of the file or with other data sources
data "aws_caller_identity" "current" {}

# # Data source to get current region
data "aws_region" "current" {}

data "aws_s3_bucket" "upload_bucket" {
  bucket = "${local.namespace}-uploads"
}

data "aws_ecr_repository" "thread_grouper" {
  name = "${local.namespace}/${local.environment}/thread_grouper"
}

data "aws_ecr_repository" "process_conversations" {
  name = "${local.namespace}/${local.environment}/process_conversations"
}

data "aws_ecr_repository" "services" {
  for_each = toset(var.services)
  name     = "${local.namespace}/${local.environment}/${each.key}"
}

data "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"
}

data "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"
}

data "aws_iam_role" "step_functions_role" {
  name = "step-functions-role"
}

data "aws_security_group" "ecs_task_security_group" {
  name = "${local.environment}-ecs-tasks-sg"
}

data "aws_security_group" "alb_security_group" {
  name = "${local.environment}-alb-sg"
}
