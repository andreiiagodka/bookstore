data "aws_iam_policy_document" "ecs_instance" {
  statement {
    actions = var.actions

    principals {
      type        = var.type
      identifiers = var.identifiers
    }
  }
}

resource "aws_iam_role" "ecs_instance" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_instance.json
}

resource "aws_iam_role_policy_attachment" "ecs_instance" {
  role       = aws_iam_role.ecs_instance.name
  policy_arn = var.policy_arn
}

resource "aws_iam_instance_profile" "ecs_instance" {
  name = var.profile_name
  role = aws_iam_role.ecs_instance.name
}
