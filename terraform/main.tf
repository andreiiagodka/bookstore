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
