output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "default_subnet_ids" {
  value = data.aws_subnet_ids.default.ids
}

output "load_balancer_security_groups" {
  value = [aws_security_group.load_balancer.id]
}
