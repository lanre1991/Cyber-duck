output "vpc_id" {
  value = module.network.vpc_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "rds_instance_id" {
  value = module.rds.rds_instance_id
}

output "waf_acl_id" {
  value = module.waf.waf_acl_id
}
