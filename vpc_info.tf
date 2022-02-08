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
    name   = "AZ"
    values = [data.aws_availability_zones.AZ.id]
  }
}

data "aws_availability_zones" "AZ" {
  state = true
}