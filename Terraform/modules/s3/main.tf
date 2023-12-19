provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "cyber_backend_bucket" {
  bucket = "cyber-backend-bucket"
  acl    = "private"
}
