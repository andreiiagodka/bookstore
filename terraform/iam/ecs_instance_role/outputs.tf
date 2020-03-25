output "ecs_instance_iam_role" {
  value = aws_iam_role.ecs_instance
}

output "iam_instance_profile_name" {
  value = aws_iam_instance_profile.ecs_instance.name
}
