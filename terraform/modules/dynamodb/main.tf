resource "aws_dynamodb_table" "conversation_store" {
  name           = "${var.environment}-conversation-store"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  ttl {
    attribute_name = "expiration_time"
    enabled        = true
  }
}