resource "aws_ecr_repository" "web_server" {
  name = "${var.project_name}/web-server"
}

resource "aws_ecr_repository" "server_app" {
  name = "${var.project_name}/server-app"
}
