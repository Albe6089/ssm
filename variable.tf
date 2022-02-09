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

####### VPC variable
# Variable definitions
// variable "region" {}

variable "vpc_id" {
  type    = string
  default = "10.0.0.0/16"
}

variable "pub-snet" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "priv-snet" {
  type    = list(any)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}
