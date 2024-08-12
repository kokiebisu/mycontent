output upload_bucket_id {
  value = aws_s3_bucket.assets_user.id
}

output upload_bucket_name {
  value = aws_s3_bucket.assets_user.bucket
}
