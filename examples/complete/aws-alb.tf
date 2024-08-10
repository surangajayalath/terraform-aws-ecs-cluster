resource "aws_lb" "public_alb" {
  name                       = "aws-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.public_alb_sg.id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = true
  tags                       = { 
    component = "network" 
  }
}

resource "aws_security_group" "public_alb_sg" {
  name        = "alb-dev-sg"
  description = "External alb security group"
  vpc_id      = var.vpc_id
  tags        = { 
    component = "network" 
  }

  ingress {
    description = "HTTPS traffic from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP traffic from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Out all traffic to internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = "80"
  protocol          = "HTTP"
  tags              = { 
    component = "network" 
  }

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.cert.arn
  tags              = { 
    component = "network" 
  }

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "From ALB External LB's Fixed Response"
      status_code  = "200"
    }
  }
}

# acm for alb
resource "aws_acm_certificate" "cert" {
  domain_name               = var.api_domain_name
  subject_alternative_names = ["www.${var.api_domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_dns" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.primary.zone_id
}
