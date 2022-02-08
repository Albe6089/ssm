variable "region" {
  type    = string
  default = "us-east-1"
}

variable "ubuntu_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "bastion-hostName" {
  description = "Name of the deployed bastion-host"
  type        = string
  default     = "bastion-host"
}