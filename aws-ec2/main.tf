terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-north-1"
}

resource "aws_instance" "myserver" {
  ami = "ami-0705384c0b33c194d"
  instance_type = "t3.micro"

  tags = {
    Name = "Server01"
  }
}