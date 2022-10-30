output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID of the vpc created in the VPC module"
}

output "public_subnet_1_id" {
  value       = aws_subnet.public[0].id
  description = "The first public subnet in the subnets"
}

output "public_subnet_2_id" {
  value       = aws_subnet.public[1].id
  description = "The second public subnet"
}

output "proxy-server-private_1_id" {
  value       = aws_subnet.proxy-server-private[0].id
  description = "The first private subnet for proxy servers"
}

output "proxy-server-private_2_id" {
  value       = aws_subnet.proxy-server-private[1].id
  description = "The second private subnet for proxy servers"
}

output "web-server-private_1_id" {
  value       = aws_subnet.web-server-private[0].id
  description = "The first private subnet for web servers"
}

output "web-server-private_2_id" {
  value       = aws_subnet.web-server-private[1].id
  description = "The second private subnet for web servers"
}

output "database_private_subnet_1_id" {
  value       = aws_subnet.database-private[0].id
  description = "The first private subnet for database servers"
}

output "database_private_subnet_2_id" {
  value       = aws_subnet.database-private[1].id
  description = "The second private subnet for database servers"
}

output "instance_profile_id" {
  value = aws_iam_instance_profile.ip.id
}
