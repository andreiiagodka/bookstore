module "task_definition" {
  source = "./task_definition"

  project_name = var.project_name
  web_server_ecr_repo = var.web_server_ecr_repo
  server_app_ecr_repo = var.server_app_ecr_repo
  log_group = var.log_group
  log_region = var.log_region
}

module "servie" {
  source = "./service"

  project_name = var.project_name
  task_definition_arn = module.task_definition.task_definition_arn
  target_group_arn = var.target_group_arn
  ecs_instance_iam_role = var.ecs_instance_iam_role
  aws_lb = var.aws_lb
  cluster_id = var.cluster_id
}
