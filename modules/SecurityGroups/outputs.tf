output "external_alb_sg_id" {
  value = aws_security_group.ext-alb-sg.id
  description = "Security group ID for external ALB"
}

output "internal_alb_sg_id" {
  value = aws_security_group.int-alb-sg.id
  description = "Security group ID for internal ALB"
}

output "bastion_sg_id" {
  value = aws_security_group.bastion-sg.id
  description = "Security group ID for bastion hosts"
}

output "proxy_server_sg_id" {
  value = aws_security_group.proxy-server-sg.id
  description = "Security group ID for proxy servers"
}

output "web_server_sg_id" {
  value = aws_security_group.webserver-sg.id
  description = "Security group ID for web servers"
}

output "database_server_sg_id" {
  value = aws_security_group.datalayer-sg.id
  description = "Security group ID for databases"
}
