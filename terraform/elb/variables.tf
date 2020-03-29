variable "load_balancer_type" {
  default = "application"
}

variable "ssl_policy" {
  default = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  default = "arn:aws:acm:eu-west-2:038639461040:certificate/0155516d-fd1f-48fc-a204-a8b0375e971f"
}

variable "project_name" {}
variable "default_subnet_ids" {}
variable "security_groups" {}
variable "default_vpc_id" {}
