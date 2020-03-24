resource "aws_lb" "this" {
  name                       = var.project_name
  subnets                    = var.default_subnet_ids
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.security_groups
}

resource "aws_lb_target_group" "this" {
  name     = aws_lb.this.name
  port     = "8080"
  protocol = "HTTP"
  vpc_id   = var.default_vpc_id

  health_check {
    path                = "/health_check"
    port                = "8080"
    protocol            = "HTTP"
    timeout             = 5
    interval            = 30
    unhealthy_threshold = 2
    healthy_threshold   = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
