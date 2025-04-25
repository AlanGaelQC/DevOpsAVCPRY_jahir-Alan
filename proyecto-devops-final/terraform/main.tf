# Definición del proveedor AWS
provider "aws" {
  region = var.region
}

# Recurso: Grupo de seguridad
resource "aws_security_group" "mi_grupo_seguridad" {
  name        = "mi-grupo-seguridad"
  description = "Grupo de seguridad para tráfico HTTP y SSH"
  vpc_id      = "vpc-04dfe2b2dbae5d794"  # VPC ya creada
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Recurso: Par de claves SSH
resource "aws_key_pair" "devops_key" {
  key_name   = "mi-clave-ssh-nueva"  # El nombre del par de claves
  public_key = file("C:\\Users\\VladG\\Desktop\\SSHKey\\mi-clave-ssh-nueva.pub")  # Ruta de la clave pública
}

# Recurso: Instancia EC2
resource "aws_instance" "devops_web_instance" {
  ami           = "ami-0b86aaed8ef90e45f"  # ID de la AMI de Amazon Linux 2
  instance_type = "t2.micro"  # Tipo de instancia
  key_name      = aws_key_pair.devops_key.key_name  # Vincula el par de claves SSH
  security_groups = [aws_security_group.mi_grupo_seguridad.name]  # Asocia el grupo de seguridad correctamente
  
  # Subred e IP pública
  subnet_id      = "subnet-xxxxxxxx"  # Reemplaza con tu ID de Subred
  associate_public_ip_address = true  # Asigna IP pública
  
  # Etiquetas
  tags = {
    Name = "devops-web-instance"  # Nombre para la instancia
  }
}

# Recurso: Elastic IP (IP pública estática)
resource "aws_eip" "devops_web_eip" {
  instance = aws_instance.devops_web_instance.id  # Asocia la IP elástica a la instancia
}

# Recurso: Volumen EBS (si se requiere almacenamiento adicional)
resource "aws_volume_attachment" "devops_web_volume" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.devops_web_volume.id  # Asocia el volumen a la instancia
  instance_id = aws_instance.devops_web_instance.id
}

# Recurso: Volumen EBS (creación de volumen adicional)
resource "aws_ebs_volume" "devops_web_volume" {
  availability_zone = aws_instance.devops_web_instance.availability_zone  # Zona de disponibilidad
  size              = 8  # Tamaño del volumen en GB
  type              = "gp2"  # Tipo de volumen
}

# Outputs
output "instance_public_ip" {
  value = aws_instance.devops_web_instance.public_ip
}

output "instance_id" {
  value = aws_instance.devops_web_instance.id
}

output "eip_public_ip" {
  value = aws_eip.devops_web_eip.public_ip
}
