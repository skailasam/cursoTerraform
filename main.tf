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
}
