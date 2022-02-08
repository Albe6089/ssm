# Network LoadBalancer
// resource "aws_lb" "nlb" {
//   name               = "${terraform.workspace}-${var.bastion-hostName}-nlb"
//   internal           = false
//   load_balancer_type = "network"
//   subnets            = [data.terraform_remote_state.remote_state.outputs.Public_IP]

//   tags = {
//     Name = "dev"
//   }
// }