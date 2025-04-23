# Configuración del proveedor
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Bucket S3
resource "aws_s3_bucket" "project_bucket" {
  bucket = "alan-devops-project-terraform-bucket-001"
  tags = {
    Name        = "Proyecto DevOps Alan"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "project_bucket_acl" {
  bucket = aws_s3_bucket.project_bucket.bucket
  acl    = "private"
}

# Security Group para permitir tráfico web y SSH
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Permitir tráfico HTTP y SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# Obtener la VPC predeterminada
data "aws_vpc" "default" {
  default = true
}

# Obtener la Subnet predeterminada (corrección)
data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
}

# Instancia EC2
resource "aws_instance" "web" {
  ami                         = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  subnet_id                   = data.aws_subnet.default.id
  associate_public_ip_address = true

  tags = {
    Name = "Alan DevOps Web"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd php
              systemctl enable httpd
              systemctl start httpd
              echo "<?php phpinfo(); ?>" > /var/www/html/index.php
              EOF
}
