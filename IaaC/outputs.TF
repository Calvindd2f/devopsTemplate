output "covenant_ip" {
  value = aws_instance.covenant.public_ip
}

output "redirector_ip" {
  value = aws_instance.redirector.public_ip
}
