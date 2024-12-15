output "ec2_public_ips" {
  value = aws_instance.nginx-server[*].public_ip
}