output "Public_IP" {
  description = "Contains the public EIP address"
  value       = ["aws_eip.b-h_eip.public_ip"]
}

output "Instance_ID" {
  description = "Contains Instance id"
  value       = aws_instance.b-h.id
}

output "VPC_ID" {
  description = "Contains VPC id"
  value       = data.aws_vpc.default.id
}