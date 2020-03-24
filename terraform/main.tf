provider "aws" {
  region = var.region
}

module "iam" {
  source = "./iam"
}

module "vpc" {
  source = "./vpc"

  project_name = var.project_name
}
