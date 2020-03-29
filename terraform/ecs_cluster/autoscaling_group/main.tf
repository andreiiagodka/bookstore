data "aws_ami" "ecs_optimized" {
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.20190709-x86_64-ebs"]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh")

  vars = {
    cluster_name = var.cluster_name
    swap_size    = var.swap_size
  }
}

resource "aws_launch_template" "this" {
  name                   = var.project_name
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  image_id               = data.aws_ami.ecs_optimized.id
  user_data              = base64encode(data.template_file.user_data.rendered)

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }
}

resource "aws_autoscaling_group" "this" {
  name                 = var.project_name
  vpc_zone_identifier  = var.default_subnet_ids
  desired_capacity     = var.number_of_instances
  min_size             = 0
  max_size             = var.number_of_instances

  launch_template {
    id = aws_launch_template.this.id
  }
}
