resource "aws_s3_bucket" "mycontent" {
  bucket = "mycontent"
  force_destroy = true
}

resource "aws_s3_bucket_cors_configuration" "mycontent_cors" {
  bucket = aws_s3_bucket.mycontent.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = var.allowed_origins
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
