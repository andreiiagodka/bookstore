resource "aws_key_pair" "this" {
  key_name   = var.project_name
  public_key = file("${path.root}/ssh_keys/${var.project_name}.pub")
}
