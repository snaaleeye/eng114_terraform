# variable.terraform 
# create variables for resources
# ami - vpc - ec2 -asg - subnet

variable "app_ami" {
  default = "ami-0b47105e3d7fc023e"
  }

variable "db_ami" {
  default = "ami-0a5bbd811afddc5f1"
  }

variable "controller_ami" {
  default = "ami-010ccb0fe0b68ddda"
  }

variable "aws_key_name" {
  default = "eng114_sharmake"
   }

variable "aws_key_path" {
  default = "~/.ssh/eng114_sharmake"
  }

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.47.0.0/16"
}

variable "public_subnets_cidr" {
  default = "10.47.1.0/24"
}

variable "private_subnets_cidr" {
  default = "10.47.10.0/24"
}

variable "region" {
  default = "eu-west-1"
}

variable "availability_zone" {
  default = "eu-west-1a"
}

variable "availability_zone2" {
  default = "eu-west-1b"
}


