output "web_server_ecr_repo" {
  value = aws_ecr_repository.web_server.repository_url
}

output "server_app_ecr_repo" {
  value = aws_ecr_repository.server_app.repository_url
}
