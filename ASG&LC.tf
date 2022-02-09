# Autoscaling-Group
resource "aws_autoscaling_group" "ASG" {
  name                = "${terraform.workspace}-${var.bastion-hostName}-ASG"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  force_delete        = true
  vpc_zone_identifier = data.terraform_remote_state.remote_state.outputs.priv-snet
  target_group_arns   = [aws_lb_target_group.nlb-target.arn]


  #Launch the latest template
  launch_template {
    id      = aws_launch_template.launch_config.id
    version = "$Latest"
  }

}

data "template_file" "user_data" {
  template = filebase64("${path.module}/userdata.sh")

}

# Launch Template
resource "aws_launch_template" "launch_config" {
  name                                 = "${terraform.workspace}-${var.bastion-hostName}-LT"
  update_default_version               = true
  image_id                             = data.aws_ami.latest-ubuntu.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.ubuntu_instance_type
  vpc_security_group_ids               = [aws_security_group.bastion-sg.id]
  user_data                            = data.template_file.user_data.rendered
  iam_instance_profile {
    name = aws_iam_instance_profile.instance_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${terraform.workspace}-${var.bastion-hostName}"
    }
  }
}