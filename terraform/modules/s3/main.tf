resource "aws_s3_bucket" "assets_user" {
  bucket = "mycontent-assets-user"
  force_destroy = true
}

resource "aws_s3_bucket_cors_configuration" "assets_user" {
  bucket = aws_s3_bucket.assets_user.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = var.allowed_origins
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.assets_user.id

  eventbridge = true
}