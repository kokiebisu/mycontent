variable upload_bucket_name {
  type = string
  description = "The name of the S3 bucket to upload blog content to"
}

variable vpc_id {
  type = string
  description = "The VPC ID to attach the security group to"
}

variable environment {
  type = string
  description = "The environment to deploy to"
}
