terraform {
  backend "s3" {
    bucket         = "cyber-backend-bucket"
    key            = "terraform.tfstate"
    region         = "your-aws-region"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
