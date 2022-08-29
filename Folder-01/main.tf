#---Creating instances---

provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "Ubuntu_Terraform" {
    count = 2
    ami = "ami-065deacbcaac64cf2"
    instance_type = "t2.micro"

    tags    = {
    Name    = "Ubuntu_Linux"
    Owner   = "Sergey Ulikhanyan"
    Project = "Terraform Lessons"
    }
}

resource "aws_instance" "Amazon_Terraform" {
    ami = "ami-0e2031728ef69a466"
    instance_type = "t2.micro"
   
    tags    = {
    Name    = "Amazon_Linux"
    Owner   = "Sergey Ulikhanyan"
    Project = "Terraform Lessons"
    }
}