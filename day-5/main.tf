provider "aws" {
  region ="us-east-1"
}
resource "aws_vpc" "balu-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name="balu-vpc"
    }
}
resource "aws_subnet" "subnet-pub" {
  vpc_id     = aws_vpc.balu-vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "subnet-pub"
  }
}
resource "aws_subnet" "subnet-pvt" {
  vpc_id     = aws_vpc.balu-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-pvt"
  }
}
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.balu-vpc.id
    tags = {
      name="balu-ing"
    }
}
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.balu-vpc.id
  tags = {
    Name= "balu-route"
  }
  route {
    cidr_block="0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.subnet-pub.id
  route_table_id = aws_route_table.name.id
}
resource "aws_security_group" "name" {
    tags = {
      name="balu-security"
    }
    vpc_id = aws_vpc.balu-vpc.id
    description = "allow"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
    }
}
resource "aws_instance" "name" {
    ami = "ami-0de716d6197524dd9"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet-pub.id
    vpc_security_group_ids = [aws_security_group.name.id]
  }
  resource "aws_eip" "name" {
    tags={
        name="balu-elp"
    }
  }
  resource "aws_nat_gateway" "name" {
    tags = {
        name="balu-nat"
    }
    subnet_id =aws_subnet.subnet-pub.id
    connectivity_type = "public"
    allocation_id = aws_eip.name.id
  }
  resource "aws_route_table" "name-nat" {
  vpc_id = aws_vpc.balu-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.name.id
  }

  tags = {
    Name = "name-nat"
  }
}
resource "aws_route_table_association" "balu-nat" {
  subnet_id      = aws_subnet.subnet-pvt.id
  route_table_id = aws_route_table.name.id
}  