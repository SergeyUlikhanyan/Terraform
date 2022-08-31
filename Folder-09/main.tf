#-----------------------------------
#   Find Latest AMI ID of:
#   - Ubuntu 18.04
#   - Amazon Linux 2
#   - Windows Server 2016Base
#-----Made by Sergey Ulikhanyan-----

provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners = ["137112412989"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_windows16_server" {
  owners = ["801119661308"]
  most_recent = true
  filter {
    name = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }
}


output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_amazon_linux_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "latest_windows16_server" {
  value = data.aws_ami.latest_windows16_server.id
}