resource "aws_instance" "backend" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.backend_sg_id]
  key_name               = "my-keypair" # Replace with your keypair

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              docker run -d -p 80:3000 nginx
              EOF

  tags = { Name = "backend-ec2" }
}
