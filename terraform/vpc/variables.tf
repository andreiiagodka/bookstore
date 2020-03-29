variable "project_name" {}

variable "cidr_blocks" {
  type = "list"
  default = [
    "0.0.0.0/0"
  ]
}
