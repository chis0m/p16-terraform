output "alb_dns_name" {
  value       = aws_lb.ext-alb.dns_name
  description = "External load balance arn"
}

output "proxy_server_tg_arn" {
  description = "External Load balancer target group"
  value       = aws_lb_target_group.proxy-server-tg.arn
}


output "wordpress_tg_arn" {
  description = "wordpress target group"
  value       = aws_lb_target_group.wordpress-tg.arn
}


output "tooling_tg_arn" {
  description = "Tooling target group"
  value       = aws_lb_target_group.tooling-tg.arn
}
