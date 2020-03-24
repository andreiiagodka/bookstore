resource "aws_iam_user" "s3_user" {
  name = var.user_name
}

resource "aws_iam_user_policy_attachment" "s3_user" {
  user       = aws_iam_user.s3_user.name
  policy_arn = var.policy_arn
}
