# Provider Configuration
provider "aws" {
  region = "us-west-2"
}

# Key Pair
resource "aws_key_pair" "deploy_key" {
  key_name   = "mern-app-key"
public_key = file("/home/lenovo/.ssh/id_ed25519.pub")
}

# Security Group
resource "aws_security_group" "mern_sg" {
  name        = "mern-sg"
  description = "Allow HTTP, HTTPS, and SSH traffic"
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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instances (Blue and Green)
resource "aws_instance" "blue" {
  ami           = "ami-0c02fb55956c7d316" # Example Amazon Linux 2 AMI
  instance_type = "t3.micro" # Changed from t2.micro to t3.micro
  key_name      = aws_key_pair.deploy_key.key_name
  security_groups = [aws_security_group.mern_sg.name]
  tags = {
    Name = "blue-instance"
        Environment = "Blue"

  }
}

resource "aws_instance" "green" {
  ami           = "ami-0c02fb55956c7d316" # Example Amazon Linux 2 AMI
  instance_type = "t3.micro" # Changed from t2.micro to t3.micro
  key_name      = aws_key_pair.deploy_key.key_name
  security_groups = [aws_security_group.mern_sg.name]
  tags = {
    Name = "green-instance"
        Environment = "Green"

  }
}

# Elastic Load Balancer
resource "aws_elb" "mern_lb" {
  name               = "mern-load-balancer"
  availability_zones = ["us-west-2a", "us-west-2b"]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  instances = [aws_instance.blue.id] # Initially point to blue instance
  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "MERN Load Balancer"
  }
}
