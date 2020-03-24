provider "aws" {
  region = var.region
}

module "iam" {
  source = "./iam"
}
