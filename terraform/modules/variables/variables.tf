variable "project_name" {
  description = "Project name that will be visible in AWS resources names"
  default     = "bookstore-terraform"
}

variable "environment" {
  description = "Application environment"
}

variable "region" {
  description = "AWS Region"

  type = map(string)
  default = {
    staging    = "eu-west-2"
    production = "eu-west-2"
  }
}

variable "log_retention_in_days" {
  description = "CloudWatch Logs retention period in days"

  type = map(number)
  default = {
    staging    = 30
    production = 90
  }
}

variable "instance_type" {
  description = "AWS EC2 instance type"

  type = map(string)
  default = {
    staging    = "t2.micro"
    production = "t2.micro"
  }
}

variable "swap_size" {
  description = "AWS EC2 instance Swap size in MB"

  type = map(number)
  default = {
    "t2.micro" = 2048
  }
}

variable "min_task_count" {
  description = "AWS ECS Cluster Minimum task count"

  type = map(number)
  default = {
    staging    = 1
    production = 2
  }
}

variable "max_task_count" {
  description = "AWS ECS Cluster Maximum task count"

  type = map(number)
  default = {
    staging    = 1
    production = 2
  }
}


variable "server_name" {
  description = "Domain name for application"

  type = map(string)
  default = {
    staging    = "bookstore-staging"
    production = "bookstore-production"
  }
}

variable "app_port" {
  description = "Port that application listens on to receive requests"

  type = map(number)
  default = {
    staging    = 3000
    production = 3000
  }
}

variable "task_cpu" {
  description = "The number of CPU units used by the task"

  type = map(number)
  default = {
    "t2.micro" = 1792
  }
}

variable "task_memory" {
  description = "The amount (in MiB) of memory used by the task"

  type = map(number)
  default = {
    "t2.micro" = 397
  }
}

variable "deployment_maximum_percent" {
  description = "Service deployment Maximum percent"

  type = map(number)
  default = {
    staging    = 100
    production = 100
  }
}
