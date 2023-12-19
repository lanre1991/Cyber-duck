provider "aws" {
  region = var.region
}

resource "aws_instance" "cyber_instances" {
  count         = 4
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.large"
  subnet_id     = aws_subnet.private_subnet.id
}

output "instance_id" {
  value = aws_instance.cyber_instances[*].id
}

resource "aws_security_group" "cyber_instance_security_group" {
  name        = "${var.name_prefix}-cyber-instance-security-group"
  description = "Security group for instances"
  vpc_id      = aws_vpc.cyber_vpc.id

  // Allow incoming traffic on port 80 (HTTP)
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow incoming traffic on port 22 (SSH) for administration (modify as needed)
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["your.admin.ip.address/32"]
  }

  // Allow outgoing traffic to all destinations
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

