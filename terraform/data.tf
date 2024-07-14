
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


# Data source to get current region
data "aws_region" "current" {}

data "aws_ecr_repository" "services" {
  for_each = toset(["gateway", "service-authentication", "service-blog", "service-user"])
  name     = each.key
  depends_on = [aws_ecr_repository.services]
}

locals {
  service_images = {
    for service in ["gateway", "service-authentication", "service-blog", "service-user"] :
    service => try(
      "${data.aws_ecr_repository.services[service].repository_url}:latest",
      "nginx:latest"
    )
  }
}
