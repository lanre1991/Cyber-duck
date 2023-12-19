main.tf
provider "aws" {
  region = var.region
}

resource "aws_wafv2_web_acl" "app_acl" {
  # WAF configurations
}

output "waf_acl_id" {
  value = aws_wafv2_web_acl.app_acl.id
}