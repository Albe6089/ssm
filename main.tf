data "terraform_remote_state" "remote_state" {
  backend = "s3"
  config = {
    bucket         = "bastion-tfstate-backend"
    key            = "env:/dev/bastion.tfstate"
    region         = var.region
    dynamodb_table = "bastion-terraform-state-lock"
    encrypt        = true
  }
}

# using a data resource to lookup the latest ubuntu ami
data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

// data "template_file" "user_data" {
//   template = file("${path.root}/userdata.sh")

// }

# creating a bastion-host
resource "aws_instance" "b-h" {
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = var.ubuntu_instance_type
  subnet_id     = data.terraform_remote_state.remote_state.outputs.pub-snet
  //   iam_instance_profile = aws_iam_instance_profile.default.name
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  user_data            = data.template_file.user_data.rendered

  tags = {
    Name = "Bastion_Host"
  }
}


