provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

# Step 1: IAM Role
resource "aws_iam_role" "example_role" {
  name = "example_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Step 2: IAM Instance Profile
resource "aws_iam_instance_profile" "example_profile" {
  name = "example_instance_profile"
  role = aws_iam_role.example_role.name
}

# Step 3: EC2 Instance with IAM Role attached via instance_profile
resource "aws_instance" "name" {
  ami                    = "ami-084a7d336e816906b"  # Replace with your AMI
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.example_profile.name

  tags = {
    Name = "MyInstance"
  }
}
