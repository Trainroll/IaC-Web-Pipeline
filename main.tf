terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

# 1. Generate an SSH Key Pair automatically so you don't do it manually
resource "tls_private_key" "vm_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "dev_key.pem"
  public_key = tls_private_key.vm_key.public_key_openssh
}

# 2. Save the private half of the key to your local folder for Ansible to use
resource "local_file" "ssh_key_pem" {
  content         = tls_private_key.vm_key.private_key_pem
  filename        = "${path.module}/dev_key.pem"
  file_permission = "0400"
}

# 3. Create a Security Group allowing SSH (22) and HTTP (80)
resource "aws_security_group" "web_sg" {
  name        = "workflow-sg"
  description = "Allow SSH and HTTP traffic"

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

# 4. Spin up the EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = "ami-030ec943c93bd6a99" # Ubuntu 22.04 LTS in us-west-1
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "DevOps-Target"
  }
}

