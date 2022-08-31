#AutoFill parameters for DEV
#This file has higher priority
#File can be named as:
#terraform.tfvars  or  *.auto.tfvars
#If you have two or more *.tfvars files for avoid conflict you must:
# terraform apply/plan -var-file="dev.auto.tfvars"

#Environment variables priority:
# 1 The terraform.tfvars file
# 2 The terraform.tfvars.json file
# 3 Any *.auto.tfvars or *.auto.tfvars.json files
# 4 Any -var and -var-file options on the command line, in the order they are provided

region                     = "ca-central-1"
instance_type              = "t2.micro"
enable_detailed_monitoring = false
allow_ports                = ["80", "22"]

common_tags = {
    Owner       = "Sergey Ulikhanyan"
    Project     = "Variables"
    CostCenter  = "00458762558"
    Environment = "dev"
  }