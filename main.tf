provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

# VPC Resource
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

# EC2 Instance Resource
resource "aws_instance" "name" {
  ami           = "ami-084a7d336e816906b"
  instance_type = "t2.micro"

  tags = {
    Name = "MyInstance"
  }
}
