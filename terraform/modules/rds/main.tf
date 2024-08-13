# Create RDS instance
resource "aws_db_instance" "default" {
  identifier        = "mydb-instance"
  engine            = "postgres"
  engine_version    = "13"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "mydb"
  username = "postgres"
  password = "mypassword"
  port     = 5432

  vpc_security_group_ids = [var.rds_security_group_id]
  publicly_accessible = var.environment == "production" ? false : true

  skip_final_snapshot = true

  tags = {
    Environment = var.environment
  }
}

# Output the RDS endpoint
output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}
