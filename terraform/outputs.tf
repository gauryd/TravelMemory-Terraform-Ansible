output "web_public_ip" {
  value = aws_instance.web.public_ip
}

output "web_private_ip" {
  value = aws_instance.web.private_ip
}

output "database_private_ip" {
  value = aws_instance.database.private_ip
}

output "vpc_id" {
  value = aws_vpc.main.id
}
