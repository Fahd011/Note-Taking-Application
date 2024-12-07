provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "mern_key" {
  key_name   = "mern-key"
  public_key = file("/home/lenovo/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "mern_sg" {
  name        = "mern-sg"
  description = "Allow SSH, HTTP, and DB connections"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017 # MongoDB default port
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mern_server" {
  ami           = "ami-05d38da78ce859165" 
  instance_type = "t3.micro"
  key_name      = aws_key_pair.mern_key.key_name
  vpc_security_group_ids = [aws_security_group.mern_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker.io docker-compose
              mkdir /home/ubuntu/mern-docker
              EOF

  tags = {
    Name = "mern-server"
  }
}

