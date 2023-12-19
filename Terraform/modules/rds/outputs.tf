output "rds_instance_id" {
  value = aws_db_instance.mydb.id
}

output "read_replica_instance_id" {
  value = aws_db_instance.read_replica[*].id
}