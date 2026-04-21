# steps:
# create a vpc with cidr block 10.0.0.0/16
# 1 public subnet with cidr block 10.0.1.0/24
# 1 private subnet with cidr block 10.0.1.0/24
# 1 internet gateway
# 1 public route table with route to IGW and association b/w public and private subnet
# 1 ec2 in vpc in private subnet and output its private ip

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

# create a vpc with cidr block 10.0.0.0/16
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

# 1 private subnet with cidr block 10.0.1.0/24
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "private-subnet"
  }
}

# 1 public subnet with cidr block 10.0.2.0/24
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "public-subnet"
  }
}
# 1 internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "internet-gateway"
  }
}

# 1 public route table with route to IGW and association b/w public and private subnet
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
}

resource "aws_route_table_association" "public-sub-rta" {
  route_table_id = aws_route_table.route-table.id
  subnet_id = aws_subnet.public-subnet.id
}

# 1 ec2 in vpc in private subnet and output its private ip
resource "aws_instance" "myserver" {
  ami = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private-subnet.id
  associate_public_ip_address = false
  tags = {
    Name = "Server02"
  }
}

output "aws_instance_private_ip" {
  value = aws_instance.myserver.private_ip
}