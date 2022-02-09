output "EIP" {
  description = "Contains the public EIP address"
  value       = aws_eip.b-h_eip.public_ip
}

output "Instance_ID" {
  description = "Contains Instance id"
  value       = aws_instance.b-h.id
}

output "VPC_ID" {
  description = "Contains VPC id"
  value       = data.aws_vpc.default.id
}

// output "AZ" {
//   description = "Contains the public IP address"
//   value       = data.aws_availability_zones.AZ.id
// }