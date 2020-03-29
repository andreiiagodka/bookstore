output "project_name" {
  value = var.project_name
}

output "project_name_env" {
  value = "${var.project_name}-${var.environment}"
}

output "environment" {
  value = var.environment
}

output "region" {
  value = lookup(var.region, var.environment)
}

output "log_retention_in_days" {
  value = lookup(var.log_retention_in_days, var.environment)
}

output "server_name" {
  value = lookup(var.server_name, var.environment)
}

output "app_port" {
  value = lookup(var.app_port, var.environment)
}

output "instance_type" {
  value = lookup(var.instance_type, var.environment)
}

output "swap_size" {
  value = lookup(var.swap_size, lookup(var.instance_type, var.environment))
}

output "min_task_count" {
  value = lookup(var.min_task_count, var.environment)
}

output "max_task_count" {
  value = lookup(var.max_task_count, var.environment)
}

output "task_cpu" {
  value = lookup(var.task_cpu, lookup(var.instance_type, var.environment))
}

output "task_memory" {
  value = lookup(var.task_memory, lookup(var.instance_type, var.environment))
}

output "deployment_minimum_healthy_percent" {
  value = lookup(var.max_task_count, var.environment) <= 1 ? 0 : 100 / lookup(var.max_task_count, var.environment)
}

output "deployment_maximum_percent" {
  value = lookup(var.deployment_maximum_percent, var.environment)
}
