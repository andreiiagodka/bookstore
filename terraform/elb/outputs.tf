output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "aws_lb" {
  value = aws_lb.this
}
