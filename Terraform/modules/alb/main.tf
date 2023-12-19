provider "aws" {
  region = var.region
}

resource "aws_security_group" "cyber_security_group" {
  name        = "${var.name_prefix}-security-group"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.cyber_vpc.id

  // Allow incoming HTTP traffic
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow incoming HTTPS traffic
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "cyber_alb" {
  name               = "${var.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.cyber_security_group.id]

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
  enable_http2                     = true
  

  access_logs {
    bucket = aws_s3_bucket.cyber_logs_bucket.bucket
  }

  tags = {
    Name = "${var.name_prefix}-ALB"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.cyber_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}

resource "aws_lb_target_group" "cyber_target_group" {
  name     = "${var.name_prefix}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.cyber_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "cyber_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cyber_target_group.id
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

resource "aws_s3_bucket" "cyber_logs_bucket" {
  bucket = "${var.name_prefix}-logs-bucket"
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

output "alb_dns_name" {
  value = aws_lb.cyber_alb.dns_name
}
