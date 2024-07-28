data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# S3 Buckets
data "aws_s3_bucket" "upload_bucket" {
  bucket = "${local.namespace}-uploads"
}

# ECR Repositories
data "aws_ecr_repository" "parse_conversations" {
  name = "${local.namespace}/${local.environment}/lambda/parse-conversations"
}

data "aws_ecr_repository" "generate_blog" {
  name = "${local.namespace}/${local.environment}/lambda/generate-blog"
}

data "aws_ecr_repository" "services" {
  for_each = toset(var.services)
  name     = "${local.namespace}/${local.environment}/ecs/${each.key}"
}

# IAM Roles
data "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"
}

data "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"
}

data "aws_iam_role" "step_functions_role" {
  name = "step-functions-role"
}

data "aws_iam_role" "lambda_role" {
  name = "lambda-role"
}

data "aws_iam_role" "eventbridge_sfn_role" {
  name = "eventbridge-sfn-role"
}

# Security Groups
data "aws_security_group" "ecs_task_security_group" {
  name = "${local.environment}-ecs-tasks-sg"
}

data "aws_security_group" "alb_security_group" {
  name = "${local.environment}-alb-sg"
}

data "aws_security_group" "rds_security_group" {
  name = "${local.environment}-rds-sg"
}