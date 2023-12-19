provider "aws" {
  region = var.region
}

resource "aws_db_instance" "mydb" {
  engine            = "mysql"
  instance_class    = "db.r5.large"  
  name              = "cyberdb"
  username          = "admin"
  allocated_storage = 20
  storage_type      = "gp2"
  multi_az          = true

  dynamic "password" {
    for_each = [var.db_secret_name]
    content {
      value = data.aws_secretsmanager_secret_version.password[var.db_secret_name].secret_string
    }
  }

  password = password[var.db_secret_name].value

  subnet_group_name     = aws_db_subnet_group.cyberdb_subnet_group.name
  vpc_security_group_ids = [aws_security_group.cyber_db_security_group.id]
}

resource "aws_db_instance" "read_replica" {
  count            = 1
  source_db_instance_identifier = aws_db_instance.cyberdb.id
  instance_class    = "db.r5.large"  
  identifier        = "mydb-read-replica-${count.index + 1}"
}

data "aws_secretsmanager_secret_version" "password" {
  for_each  = [var.db_secret_name]
  secret_id = var.db_secret_name
}

output "rds_instance_id" {
  value = aws_db_instance.mydb.id
}

output "read_replica_instance_id" {
  value = aws_db_instance.read_replica[*].id
}
