resource "aws_instance" "name" {
    ami = "ami-084a7d336e816906b"
    instance_type = "t3.micro"
    tags = {
    Name = "MyInstance"
  }
}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      name ="balu-vpc-1"
    }
  
}