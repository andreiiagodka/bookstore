variable "project_name" {}
variable "web_server_ecr_repo" {}
variable "server_app_ecr_repo" {}
variable "log_group" {}
variable "log_region" {}
variable "network_mode" {
  default = "bridge"
}
