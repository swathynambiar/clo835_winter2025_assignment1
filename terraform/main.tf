provider "aws" {
  region = var.aws_region
}

# Fetch the default VPC to deploy the resources
data "aws_vpc" "default_vpc" {
  default = true
}

# # Generate SSH Key Pair to connect to the EC2 instance
# resource "aws_key_pair" "my_key_pair" {
#   key_name   = var.key_pair_name
#   public_key = file("~/.ssh/vockey.pem") # Make sure this path is correct
# }

# Create Security Group for EC2 instance to allow necessary traffic
resource "aws_security_group" "my_ec2_security_group" {
  name        = "my-ec2-sg"
  description = "Security group for EC2 instance allowing HTTP, MySQL, and SSH"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    description = "HTTP on port 8081"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP on port 8082"
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP on port 8083"
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MySQL traffic on port 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access for server management"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP traffic on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-ec2-security-group"
  }
}

# Deploy the EC2 instance with the specified configurations
resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  security_groups        = [aws_security_group.my_ec2_security_group.id]
  associate_public_ip_address = true
  key_name               = var.key_pair_name
  iam_instance_profile   = var.iam_role_name

  tags = {
    Name = "Custom-Web-Server"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    service docker start
  EOF
}

# Create the ECR repositories for webapp and mysql
resource "aws_ecr_repository" "webapp" {
  name = "webapp/my_app"
}

resource "aws_ecr_repository" "mysql" {
  name = "webapp/my_db"
}
