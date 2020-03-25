resource "aws_cloudwatch_log_group" "this" {
  name              = var.project_name
  retention_in_days = 7
}
