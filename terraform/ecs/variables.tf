variable "project_name" {}
variable "target_group_arn" {}
variable "ecs_instance_iam_role" {}
variable "aws_lb" {}
variable "web_server_ecr_repo" {}
variable "server_app_ecr_repo" {}
variable "log_group" {}
variable "log_region" {}
variable "cluster_id" {}
variable "network_mode" {
  default = "bridge"
}
