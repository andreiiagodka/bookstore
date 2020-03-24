variable "actions" {
  type = "list"
  default = [
    "sts:AssumeRole"
  ]
}

variable "type" {
  default = "Service"
}

variable "identifiers" {
  type = "list"
  default = [
    "ec2.amazonaws.com"
  ]
}

variable "role_name" {
  default = "bookstore-ecs-instance"
}

variable "policy_arn" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

variable "profile_name" {
  default = "bookstore-ecs-instance"
}
