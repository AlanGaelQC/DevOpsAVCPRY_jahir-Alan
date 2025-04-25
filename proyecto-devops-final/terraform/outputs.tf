# Output de la IP pública de la instancia EC2
output "ec2_public_ip" {
  value       = aws_instance.web.public_ip
  description = "La IP pública de la instancia EC2"
}

# Output del nombre del bucket S3
output "s3_bucket_name" {
  value       = aws_s3_bucket.project_bucket.bucket
  description = "El nombre del bucket S3"
}