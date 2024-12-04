terraform {
  backend "s3" {
    bucket       = "terraform-state-devops-2024"
    key          = "backend/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "nginx-server" {
  ami           = "ami-0453ec754f44f9a4a" # agrega el ami Amazon Linux de acuerdo a tu region
  instance_type = "t2.micro"
  #count = 2

  tags = {
    Name        = "Nginx-Server"
    Environment = "test"
    Owner       = "enriqueadhemar@gmail.com" # Puedes agregar tu mail para el tag
    Team        = "DevOps"
  }

  user_data                   = <<-EOF
             #!/bin/bash
             sudo yum install -y nginx
             sudo systemctl enable nginx
             sudo systemctl start nginx
             EOF
  user_data_replace_on_change = true
  vpc_security_group_ids      = [aws_security_group.nginx-server-sg.id]
}

resource "aws_security_group" "nginx-server-sg" {
  name        = "nginx-server-sg"
  description = "Security group allowing SSH and HTTP access"


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
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

