resource "aws_ecs_service" "this" {
  name                               = var.project_name
  cluster                            = var.cluster_id
  task_definition                    = var.task_definition_arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  load_balancer {
    container_name   = "web-server"
    container_port   = 8080
    target_group_arn = var.target_group_arn
  }

  depends_on = [
    var.ecs_instance_iam_role,
    var.aws_lb
  ]
}
