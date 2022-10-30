# ----------------------------
#Internal Load Balancers for webservers
#---------------------------------

resource "aws_lb" "internal-alb" {
  name     = "${var.project}-${var.workspace}-Internal-ALB"
  internal = true
  security_groups = [
    var.internal_alb_sg_id,
  ]

  subnets = [
    var.web_private_subnet_1_id,
    var.web_private_subnet_2_id
  ]

  tags = merge({ "Name" : "${var.project}-${var.workspace}-InternalALB" }, var.tags)

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

# --- target group  for wordpress -------

resource "aws_lb_target_group" "wordpress-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "${var.project}-${var.workspace}-WordpressApp-TG"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

# --- target group for tooling -------

resource "aws_lb_target_group" "tooling-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "${var.project}-${var.workspace}-ToolingApp-TG"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

####********************************************************#####

# For this aspect a single listener was created for the wordpress which is default,
# A rule was created to route traffic to tooling when the host header changes

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.internal-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.chisomejim.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tg.arn
  }
}

# listener rule for tooling target

resource "aws_lb_listener_rule" "tooling-listener" {
  listener_arn = aws_lb_listener.web-listener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tooling-tg.arn
  }

  condition {
    host_header {
      values = ["tooling.chisomejim.click"]
    }
  }
}
