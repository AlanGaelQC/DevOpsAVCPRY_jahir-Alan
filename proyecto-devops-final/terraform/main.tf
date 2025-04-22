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

  required_version = ">= 1.3.0"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "alan-devops-project-terraform-bucket-001"  # Nombre único
  force_destroy = true  # Esta propiedad ayuda a eliminar el bucket incluso si tiene objetos
}
