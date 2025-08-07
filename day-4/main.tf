resource "aws_instance" "name" {
    ami = "ami-084a7d336e816906b"
    instance_type = "t3.micro"
    tags = {
    Name = "MyInstance"
  }
}
resource "aws_vpc" "name" {
  cidr_block           = "10.0.0.0/16"  # Required
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc-1"
  }
}
