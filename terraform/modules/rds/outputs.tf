output db_host {
  value       = aws_db_instance.default.address
  description = "The host of the RDS instance"
}
