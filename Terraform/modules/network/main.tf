provider "aws" {
  region = var.region
}

resource "aws_vpc" "cyber_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "cyber-vpc"
  }
}

resource "aws_subnet" "cyber_private_subnet" {
  vpc_id                  = aws_vpc.cyber_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"  
  map_public_ip_on_launch = false

  tags = {
    Name = "cyber-private-subnet"
  }
}

resource "aws_subnet" "cyber_public_subnet" {
  vpc_id                  = aws_vpc.cyber_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"  
  map_public_ip_on_launch = true

  tags = {
    Name = "cyber-public-subnet"
  }
}

resource "aws_subnet" "cyber_private_subnet_2" {
  vpc_id                  = aws_vpc.cyber_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"  
  map_public_ip_on_launch = false

  tags = {
    Name = "cyber-private-subnet-2"
  }
}

resource "aws_subnet" "cyber_public_subnet_2" {
  vpc_id                  = aws_vpc.cyber_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1d"  
  map_public_ip_on_launch = true

  tags = {
    Name = "cyber-public-subnet-2"
  }
}

output "vpc_id" {
  value = aws_vpc.cyber_vpc.id
}
