variable "user_name" {
  default = "bookstore-s3-user"
}

variable "policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
