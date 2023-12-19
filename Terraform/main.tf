provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"
  region = var.region
}

module "instances" {
  source = "./modules/instances"
  region = var.region
}

module "alb" {
  source = "./modules/alb"
  region = var.region
}

module "rds" {
  source = "./modules/rds"
  region = var.region
}

module "waf" {
  source = "./modules/waf"
  region = var.region
}
