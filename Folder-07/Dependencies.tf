#-------------------------------
#    --- AWS Instances---
#  --- Using Dependencies---
# --Made by Sergey Ulikhanyan--
#-------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_Server-Web" {
  ami                    = "ami-0e2031728ef69a466"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_SecGroup.id]
  
  tags    = {
   Name    = "Server"
   }
   depends_on = [
     aws_instance.my_Server-DB
   ]
 }

 resource "aws_instance" "my_Server-App" {
  ami                    = "ami-0e2031728ef69a466"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_SecGroup.id]
  
  tags    = {
   Name    = "Application"
   }
   depends_on = [
     aws_instance.my_Server-Web
   ]
 }

 resource "aws_instance" "my_Server-DB" {
  ami                    = "ami-0e2031728ef69a466"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_SecGroup.id]
  
  tags    = {
   Name    = "DataBase"
   }
 }

resource "aws_security_group" "my_SecGroup" {
  name        = "Dynamic SecGroup"
  description = "My secGroup"

dynamic "ingress" {
  for_each = ["80", "443", "22"]
  content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  
  egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
   }

  tags   = {
   Name  = "Terraform SecGroup"
   }
}