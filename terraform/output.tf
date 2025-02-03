output "web_server_public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "The public IP address assigned to the EC2 web server instance"
}

output "my_ec2_security_group_id" {
  value       = aws_security_group.my_ec2_security_group.id
  description = "The security group ID associated with the EC2 instance"
}

output "webapp_repo_url" {
  value       = aws_ecr_repository.webapp.repository_url
  description = "Web application ECR repository URL"
}

output "mysql_repo_url" {
  value       = aws_ecr_repository.mysql.repository_url
  description = "MySQL ECR repository URL"
}