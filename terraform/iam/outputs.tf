output "ecs_instance_iam_role" {
  value = module.ecs_instance_role.ecs_instance_iam_role
}

output "iam_instance_profile_name" {
  value = module.ecs_instance_role.iam_instance_profile_name
}
