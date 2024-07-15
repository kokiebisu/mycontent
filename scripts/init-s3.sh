#!/bin/bash
set -e

echo "Initializing S3 bucket with CORS configuration..."

# Create the S3 bucket
awslocal s3 mb s3://mycontent

# Create a temporary CORS configuration file
cat <<EOF > /tmp/cors_config.json
{
  "CORSRules": [
    {
      "AllowedOrigins": ["http://localhost:3000"],
      "AllowedMethods": ["GET", "PUT", "POST", "DELETE", "HEAD"],
      "AllowedHeaders": ["*"],
      "ExposeHeaders": ["ETag"],
      "MaxAgeSeconds": 3000
    }
  ]
}
EOF

# Apply the CORS configuration to the bucket
awslocal s3api put-bucket-cors --bucket mycontent --cors-configuration file:///tmp/cors_config.json

echo "S3 bucket initialized with CORS configuration."
