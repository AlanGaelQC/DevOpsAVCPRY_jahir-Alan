output "ec2_public_ip" {
  value       = aws_instance.web.public_ip
  description = "La IP pública de la instancia EC2"
}

/*
output "rds_endpoint" {
  value       = aws_db_instance.dev_db.endpoint
  description = "El endpoint de la base de datos RDS"
}

output "rds_username" {
  value       = aws_db_instance.dev_db.username
  description = "Nombre de usuario de la base de datos RDS"
}

output "rds_database_name" {
  value       = aws_db_instance.dev_db.db_name
  description = "Nombre de la base de datos RDS"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID de la VPC creada"
}
*/
