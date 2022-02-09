data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  vpc_id = data.aws_vpc.default
}
# Assiging a static public IP address to the bastion host
// resource "aws_eip" "b-h_eip" {
//   instance = aws_instance.b-h.id
//   vpc      = true
// }


// data "aws_subnets" "public_ip" {
//   filter {
//     name   = "pub"
//     values = ["subnet-0b152e8a70694e0d0"]
//   }
// }
