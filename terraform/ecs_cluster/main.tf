module "cluster" {
  source = "./cluster"

  project_name = var.project_name
}

module "autoscaling_group" {
  source = "./autoscaling_group"

  project_name = var.project_name
  cluster_name = module.cluster.cluster_name
  key_name = var.key_pair.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile_name = var.iam_instance_profile_name
  default_subnet_ids = var.default_subnet_ids
}
