data "template_file" "container_definitions" {
  template = file("${path.module}/templates/container_definitions.json")

  vars = {
    web_server_ecr_repo = var.web_server_ecr_repo
    server_app_ecr_repo = var.server_app_ecr_repo

    log_group  = var.log_group
    log_region = var.log_region
  }
}

resource "aws_ecs_task_definition" "this" {
  family       = var.project_name
  network_mode = var.network_mode
  cpu          = 896
  memory       = 896

  container_definitions = data.template_file.container_definitions.rendered

  volume {
    name = "redis"

    docker_volume_configuration {
      scope         = "shared"
      autoprovision = true
    }
  }

  volume {
    name = "postgres"

    docker_volume_configuration {
      scope         = "shared"
      autoprovision = true
    }
  }

  volume {
    name = "public"
  }
}
