resource "aws_alb_target_group" "target_group" {
  name                 = var.target_group_name
  port                 = var.target_group_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = 5
  target_type          = "ip"
  tags                 = var.tags


  health_check {
    protocol            = "HTTP"
    path                = var.health_check_path
    port                = var.target_group_port
    interval            = 120
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = var.health_check_matcher
  }
}

resource "aws_lb_listener_rule" "alb_listener_rule" {
  listener_arn = var.alb_https_listener_arn
  priority     = var.alb_listner_priority
  tags         = var.tags

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }

  condition {
    host_header {
      values = ["${var.api_domain_name}"]
    }
  }

  condition {
    path_pattern {
      values = ["${var.routing_path}*"]
    }
  }
}