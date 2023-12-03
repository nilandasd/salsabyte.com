resource "aws_lb" "salsabyte" {
  name               = "salsabyte"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]

  subnets = [
    aws_subnet.public_us_east_1a.id,
    aws_subnet.public_us_east_1b.id
  ]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.salsabyte.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "tls" {
  load_balancer_arn = aws_lb.salsabyte.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.www.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.salsabyte.arn
  }

  depends_on = [aws_acm_certificate_validation.www]
}

resource "aws_lb_target_group" "salsabyte" {
  name       = "salsabyte"
  port       = 8080
  protocol   = "HTTP"
  vpc_id     = aws_vpc.main.id
  slow_start = 0

  load_balancing_algorithm_type = "round_robin"

  stickiness {
    enabled = false
    type    = "lb_cookie"
  }

  health_check {
    enabled             = true
    port                = 8080
    interval            = 30
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}
