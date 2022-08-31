#                  ----Changing default vars from CLI----
# terraform apply/plan -var="region=us-east-1" -var="instance_type=t3.small" 

#-----Also You Can Export Vars-----
#   export TF_VAR_region=us-west-2
#  (export TF_VAR_varName=varValue)
#  (echo $TF_VAR_region) OR (env | grep TF_VAR)---> for checking
#   unset TF_VAR_region == unset TF_VAR_varName---> unset variable from SHELL environment 

variable "region" {
  description = "Please Enter AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t2.micro"
}


variable "allow_ports" {
  description = "List of Ports to open"
  type        = list
  default     = ["80", "443", "22"]
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = false
}


variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map
  default = {
    Owner       = "Sergey Ulikhanyan"
    Project     = "Terraform"
    CostCenter  = "00458762558"
    Environment = "development"
  }
}

