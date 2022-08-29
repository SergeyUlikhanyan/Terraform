#-------------------------------
#    --- Creating VPC---
#       --- Subnets---
#   ---Get data Outputs---
# --Made by Sergey Ulikhanyan--
#-------------------------------

provider "aws" {}


resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags   = {
    Name = "My VPC"
  }
}

resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  tags       = {
    Name     = "Public Subnet-1"
    Account  = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region   = data.aws_region.region.name
  }
}

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.10.0/24"
  tags       = {
    Name     = "Public Subnet-2"
    Account  = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region   = data.aws_region.region.name
  }
}


data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "region" {}
data "aws_vpcs" "current" {}



output "Data" {
  value = data.aws_availability_zones.working.names
}
output "current" {
  value = data.aws_caller_identity.current.account_id
}
output "region" {
  value = data.aws_region.region.name
}
output "description" {
  value = data.aws_region.region.description
}
output "current_vpcs" {
  value = data.aws_vpcs.current.ids
}
output "prod_vpc" {
  value = aws_vpc.my_vpc.id
}
output "prod_vpc_cidr" {
  value = aws_vpc.my_vpc.cidr_block
}