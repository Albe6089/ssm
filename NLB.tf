# Network LoadBalancer
resource "aws_lb" "nlb" {
  name               = "${terraform.workspace}-${var.bastion-hostName}-my-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = data.terraform_remote_state.remote_state.outputs.pub-snet

  tags = {
    Name = "dev"
  }
}


# Network Loadbalancer target-group
resource "aws_lb_target_group" "nlb-target" {
  name     = "${terraform.workspace}-${var.bastion-hostName}-nlb-tg"
  port     = 22
  protocol = "TCP"
  vpc_id   = data.terraform_remote_state.remote_state.outputs.vpc_id
}

# Network Loadbalancer listerner
resource "aws_lb_listener" "nlb-listerner" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "22"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb-target.arn
  }
}