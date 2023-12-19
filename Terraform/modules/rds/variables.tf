variable "region" {
  description = "AWS region"
  type        = string
}

variable "db_secret_name" {
  description = "AWS Secrets Manager secret name for RDS password"
  type        = string
}
