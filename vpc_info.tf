data "aws_vpc" "default" {
  default = true
}

# Assiging a static public IP address to the bastion host
resource "aws_eip" "b-h_eip" {
  instance = aws_instance.b-h.id
  vpc      = true
}

data "aws_subnets" "public_ip" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}