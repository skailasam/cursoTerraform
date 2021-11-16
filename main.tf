terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.62.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dev" {
  count = 3
  ami = "ami-0279c3b3186e54acd"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_instance" "dev4" {
  ami = "ami-0279c3b3186e54acd"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev4"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
  depends_on = [
    # Essa referencia é o nome DO RESOURCE
    aws_s3_bucket.dev4
  ]
}

resource "aws_instance" "dev5" {
  ami = "ami-0279c3b3186e54acd"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "dev5"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "Permitir acesso as VPC via ssh"

  ingress {
      # description      = "Permitir acesso as VPC via ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["177.9.214.75/32"]
  }

  tags = {
    Name = "acesso-ssh"
  }
}

# O nome no resource vai ser o utilizado pelo terraform
resource "aws_s3_bucket" "dev4" {
  # Esse nome aqui serve de referencia pra AWS, nao pro terraform
  bucket = "hcecconi-dev4"
  acl    = "private"

  tags = {
    Name = "hcecconi-dev4"
  }
}