# Create ALB
resource "aws_lb" "alb" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group]  # Ensure this is a list of security group IDs
  subnets            = var.public_subnet_ids
  tags = {
    "map-migrated"         = "d-server-013zvevbqyyom2"
    "map-migrated-app"     = "web-server.asp"
  }

  enable_deletion_protection = false

  timeouts {
    create = "10m"
    delete = "10m"
  }

  # Specify idle timeout as an argument
  idle_timeout = 4000
}

# Create http listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      protocol    = "HTTPS"
      port        = "443"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }
}

# Creae https listener
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = var.alb_certificate_arn
  # TODO Use this line, if use import certificate
  # certificate_arn = "arn:aws:acm:ap-southeast-1:030150888082:certificate/8864d186-ff65-47a2-867b-e365e893a476"
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tg_apps.arn
        
    }
}

# Create target group apps port 8069
resource "aws_lb_target_group" "tg_apps" {
  name                = "example-apps"
  port                = 8069
  protocol            = "HTTP"
  target_type         = "instance"
  vpc_id              = var.vpc

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 15
  }

  tags = {
    "Name" = "TG-Example-Apps"
  }

  # Specify load balancing algorithm directly as an argument
  load_balancing_algorithm_type = "round_robin"
  
  # Specify stickiness directly as an argument
  stickiness {
    enabled                     = true
    type                        = "lb_cookie"
    cookie_duration             = 86400
  }
}