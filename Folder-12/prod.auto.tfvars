#AutoFill parameters for PROD
#This file has higher priority
#File can be named as:
#terraform.tfvars  or  *.auto.tfvars
#If you have two or more *.tfvars files for avoid conflict you must:
# terraform apply/plan -var-file="prod.auto.tfvars"

#Environment variables priority:
# 1 The terraform.tfvars file
# 2 The terraform.tfvars.json file
# 3 Any *.auto.tfvars or *.auto.tfvars.json files
# 4 Any -var and -var-file options on the command line, in the order they are provided

region                     = "eu-central-1"
instance_type              = "t3.small"
enable_detailed_monitoring = true
allow_ports                = ["443", "80"]

common_tags = {
    Owner       = "Sergey Ulikhanyan"
    Project     = "Variables"
    CostCenter  = "004587625588524"
    Environment = "prod"
  }