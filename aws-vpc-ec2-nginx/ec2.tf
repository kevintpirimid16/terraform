resource "aws_instance" "nginx-server" {
  ami           = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
  tags = {
    Name = "nginx-server"
  }
}