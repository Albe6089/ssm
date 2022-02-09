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

variable "desired_capacity" {
  type    = string
  default = "1"
}
variable "max_size" {
  type    = string
  default = "1"
}
variable "min_size" {
  type    = string
  default = "1"
}

variable "ingress_rules" {
  type = map(object({
    port        = number
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
  default = {
    "22" = {
      port        = 22
      description = "Port 22"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}

variable "egress_rules" {
  type = map(object({
    port             = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
  }))
  default = {
    "0" = {
      port             = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

}