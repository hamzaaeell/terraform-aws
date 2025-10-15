# Create security group for ALB
resource "aws_security_group" "alb" {
  name_prefix = "${var.project_name}-${var.environment}-alb-"
  vpc_id      = var.vpc_id

  # HTTP access
  ingress {
    from_port   = var.listener_port
    to_port     = var.listener_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  # HTTPS access if enabled
  dynamic "ingress" {
    for_each = var.enable_https ? [1] : []
    content {
      from_port   = var.https_port
      to_port     = var.https_port
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-alb-sg"
    Environment = var.environment
    Project     = var.project_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create ALB
resource "aws_lb" "main" {
  name               = var.alb_name != "" ? var.alb_name : "${var.project_name}-${var.environment}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = length(var.security_group_ids) > 0 ? var.security_group_ids : [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = var.enable_deletion_protection
  ip_address_type           = var.ip_address_type

  tags = {
    Name        = var.alb_name != "" ? var.alb_name : "${var.project_name}-${var.environment}-alb"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create target group
resource "aws_lb_target_group" "main" {
  name     = var.target_group_name != "" ? var.target_group_name : "${var.project_name}-${var.environment}-tg"
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.target_group_vpc_id != "" ? var.target_group_vpc_id : var.vpc_id

  health_check {
    enabled             = var.health_check_enabled
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = var.health_check_matcher
  }

  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  dynamic "stickiness" {
    for_each = var.stickiness_enabled ? [1] : []
    content {
      enabled            = true
      type               = var.stickiness_type
      cookie_duration    = var.stickiness_cookie_duration
      cookie_name        = var.stickiness_type == "app_cookie" ? null : ""
    }
  }

  tags = {
    Name        = var.target_group_name != "" ? var.target_group_name : "${var.project_name}-${var.environment}-tg"
    Environment = var.environment
    Project     = var.project_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create HTTP listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.listener_default_action_type
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-http-listener"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create HTTPS listener if enabled
resource "aws_lb_listener" "https" {
  count             = var.enable_https ? 1 : 0
  load_balancer_arn = aws_lb.main.arn
  port              = var.https_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.listener_default_action_type
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-https-listener"
    Environment = var.environment
    Project     = var.project_name
  }
}