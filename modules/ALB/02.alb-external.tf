resource "aws_lb" "ext-alb" {
  name     = "${var.project}-${var.workspace}-ExternalALB"
  internal = false
  security_groups = [
    var.external_alb_sg_id,
  ]

  subnets = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]

  tags = merge({ "Name" : "${var.project}-${var.workspace}-ExternalALB" }, var.tags)

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

####********************************************************#####

# Creates Target Group for Proxy Server
resource "aws_lb_target_group" "proxy-server-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "${var.project}-${var.workspace}-ProxyServer-TG"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

# Creates ALB Listener to point to the proxy server target group
resource "aws_lb_listener" "proxy-server-listener" {
  load_balancer_arn = aws_lb.ext-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.chisomejim.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.proxy-server-tg.arn
  }
}

####********************************************************#####

output "alb_target_group_arn" {
  value = aws_lb_target_group.proxy-server-tg.arn
}
