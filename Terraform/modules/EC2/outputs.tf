output "Public-ip" {
  value = aws_instance.app[*].public_ip
}

output "ec2_id" {
  value = aws_instance.app[*].id
}

