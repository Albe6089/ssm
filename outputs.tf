### My base
// output "EIP" {
//   description = "Contains the public EIP address"
//   value       = aws_eip.b-h_eip.public_ip
// }

output "Instance_ID" {
  description = "Contains Instance id"
  value       = aws_instance.b-h.id
}

output "VPC_ID" {
  description = "Contains VPC id"
  value       = data.aws_vpc.default.id
}

############ Adding VPC Outputs

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "pub-snet" {
  value = aws_subnet.pub-snet.*.id
}

output "priv-snet" {
  value = aws_subnet.priv-snet.*.id
}