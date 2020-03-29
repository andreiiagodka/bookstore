resource "random_id" "bucket_id" {
    byte_length = 2
}

resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-${random_id.bucket_id.dec}"
}
