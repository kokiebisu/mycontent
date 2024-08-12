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
  bucket = "${local.namespace}-assets-user"
}

data "aws_ecr_repository" "parse_conversations" {
  name = "${local.environment}/parse-conversations"
}

data "aws_ecr_repository" "generate_blog" {
  name = "${local.environment}/generate-blog"
}

data "aws_ecr_repository" "services" {
  for_each = toset(var.services)
  name     = each.key
}

data "aws_iam_role" "ecs_execution_role" {
  name = "${local.environment}-ecs-execution-role"
}

data "aws_iam_role" "ecs_task_role" {
  name = "${local.environment}-ecs-task-role"
}

data "aws_security_group" "ecs_task_security_group" {
  name = "${local.environment}-ecs-task-security-group"
}

data "aws_security_group" "alb_security_group" {
  name = "${local.environment}-alb-security-group"
}

# Start of Selection
data "aws_db_instance" "rds_db_instance" {
  db_instance_identifier = "${local.environment}-rds-db-instance"
}