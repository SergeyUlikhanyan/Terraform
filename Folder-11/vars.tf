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
