output "instance_id" {
  value = aws_instance.my_instances[*].id
}
