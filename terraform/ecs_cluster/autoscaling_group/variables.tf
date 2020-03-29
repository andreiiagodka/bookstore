variable "project_name" {}
variable "cluster_name" {}
variable "key_name" {}

variable "vpc_security_group_ids" {
  description = "Security group for ECS cluster instance"
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile with ECS instance role"
}

variable "instance_type" {
  description = "EC2 instance type to run in ECS cluster"
  default     = "t2.micro"
}

variable "swap_size" {
  description = "Size of the swap file"
  default     = 2000
}

variable "number_of_instances" {
  description = "Number of instances in ECS cluster"
  default     = 1
}

variable "default_subnet_ids" {
  description = "Subnet ids to launch ECS cluster instances in"
}
