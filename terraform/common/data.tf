
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
