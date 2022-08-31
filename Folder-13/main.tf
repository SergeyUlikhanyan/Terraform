#----------------------------
#My Terraform
#Local Variables
#Made by S.Ulikhanyan
#----------------------------

provider "aws" {
    region = "eu-central-1"
}


data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  
}

locals {
  full_project_name = "${var.environment}-${var.project_name}"
  project_owner     = "${var.owner} owner of ${var.project_name}"
}

locals {
  country  = "Armenia"
  city     = "Yeravan"
  az_list  = join(",", data.aws_availability_zones.available.names)
}

resource "aws_eip" "my_static_IP" {
  tags = {
    Name       = "Static IP"
    Owner      = var.owner
    Project    = local.full_project_name
    Proj_owner = local.project_owner
    city       = local.city
    country    = local.country
    region_azs = local.az_list
  }
}