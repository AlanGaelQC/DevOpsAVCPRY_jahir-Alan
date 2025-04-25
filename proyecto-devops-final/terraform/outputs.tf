output "ec2_public_ip" {
  value       = aws_instance.devops_web_instance.public_ip
  description = "La IP pública de la instancia EC2"
}

output "instance_id" {
  value       = aws_instance.devops_web_instance.id
  description = "El ID de la instancia EC2"
}

output "eip_public_ip" {
  value       = aws_eip.devops_web_eip.public_ip
  description = "La IP pública elástica asociada a la instancia"
}

output "instance_private_ip" {
  value       = aws_instance.devops_web_instance.private_ip
  description = "La IP privada de la instancia EC2"
}

output "security_group_id" {
  value       = aws_security_group.web_sg.id
  description = "El ID del grupo de seguridad asociado a la instancia"
}

output "key_pair_name" {
  value       = aws_key_pair.devops_key.key_name
  description = "El nombre del par de claves asociado a la instancia"
}

output "eip_association_id" {
  value       = aws_eip.devops_web_eip.association_id
  description = "El ID de la asociación de la IP elástica"
}
