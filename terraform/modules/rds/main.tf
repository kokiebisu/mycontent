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

  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true

  tags = {
    Environment = var.environment
  }
}

# Create a security group for RDS
resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Allow inbound traffic from ECS tasks to RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_task_security_group_id]
  }

  tags = {
    Environment = var.environment
  }
}

# Output the RDS endpoint
output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}
