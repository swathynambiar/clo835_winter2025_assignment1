variable "subnet_id" {
  description = "The Subnet ID where EC2 will be launched"
  default     = "subnet-046ebc06358626f87"  # Replace with your Subnet ID
}

variable "vpc_id" {
  description = "The VPC ID where EC2 will be launched"
  default     = "vpc-0360b43b62294830c"     # Replace with your VPC ID
}

variable "aws_region" {
  description = "AWS region to create resources"
  default     = "us-east-1"  # Change the region if needed
}

variable "ami_id" {
  description = "AMI ID to be used for EC2 instance"
  default     = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI, update as needed
}

variable "instance_type" {
  description = "EC2 Instance type"
  default     = "t2.micro"  # Update the instance type as needed
}

variable "key_pair_name" {
  description = "Key pair name for EC2 instance SSH access"
  default     = "vockey"  # Replace with your desired key pair name
}

variable "iam_role_name" {
  description = "IAM role name to be attached to EC2 instance"
  default     = "LabInstanceProfile"  # Replace with your IAM role name
}