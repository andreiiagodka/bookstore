provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket  = "bookstore-terraform"
    key     = "terraform/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}

module "s3" {
  source = "./s3"

  project_name = var.project_name
}

module "iam" {
  source = "./iam"
}

module "vpc" {
  source = "./vpc"

  project_name = var.project_name
}

module "ecr" {
  source = "./ecr"

  project_name = var.project_name
}

module "elb" {
  source = "./elb"

  project_name = var.project_name
  default_subnet_ids = module.vpc.default_subnet_ids
  security_groups = module.vpc.load_balancer_security_groups
  default_vpc_id = module.vpc.default_vpc_id
}
