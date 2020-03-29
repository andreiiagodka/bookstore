provider "aws" {
  version = "~> 2.55"
  region  = var.region
}

provider "template" {
  version = "~> 2.1"
}
