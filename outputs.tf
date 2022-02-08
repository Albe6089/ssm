output "Public_IP" {
  description = "Contains the public EIP address"
  value       = aws_eip.b-h_eip.public_ip
}

output "Instance_ID" {
  description = "Contains the public IP address"
  value       = aws_instance.b-h.id
}