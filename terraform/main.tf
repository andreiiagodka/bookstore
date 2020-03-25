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

module "elb" {
  source = "./elb"

  project_name = var.project_name
  default_subnet_ids = module.vpc.default_subnet_ids
  security_groups = module.vpc.load_balancer_security_groups
  default_vpc_id = module.vpc.default_vpc_id
}

module "ecr" {
  source = "./ecr"

  project_name = var.project_name
}

module "ec2" {
  source = "./ec2"

  project_name = var.project_name
}

module "cloudwatch" {
  source = "./cloudwatch"

  project_name = var.project_name
}

module "ecs_cluster" {
  source = "./ecs_cluster"

  project_name = var.project_name
  key_pair = module.ec2.key_pair
  vpc_security_group_ids = module.vpc.cluster_instance_security_groups
  iam_instance_profile_name = module.iam.iam_instance_profile_name
  default_subnet_ids = module.vpc.default_subnet_ids
}

module "ecs" {
  source = "./ecs"

  project_name = var.project_name
  web_server_ecr_repo = module.ecr.web_server_ecr_repo
  server_app_ecr_repo = module.ecr.server_app_ecr_repo
  log_group = module.cloudwatch.log_group
  log_region = var.region
  target_group_arn = module.elb.target_group_arn
  ecs_instance_iam_role = module.iam.ecs_instance_iam_role
  aws_lb = module.elb.aws_lb
  cluster_id = module.ecs_cluster.cluster_id
}
