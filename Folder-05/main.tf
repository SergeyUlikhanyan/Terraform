#-------------------------------
#    --- AWS Web Server ---
#       --- User Data ---
#       --- ElasticIP ---
#     --- Min. Downtime ---
# --Made by Sergey Ulikhanyan--
#-------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_eip" "MyStaticIP" {
  instance = aws_instance.my_Web_Server.id
}

resource "aws_instance" "my_Web_Server" {
  ami                    = "ami-0e2031728ef69a466"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_SecGroup.id]
  user_data = templatefile("user_data.tpl", {
    f_name = "Sergey",
    l_name = "Ulikhanyan",
    names  = ["Name1", "Name2", "Name3", "Name4" ]
  })

  user_data_replace_on_change = true

  tags    = {
   Name    = "AmazonLinux"
   Owner   = "Sergey Ulikhanyan"
   }
  lifecycle {
    create_before_destroy = true
  } 
}

resource "aws_security_group" "my_SecGroup" {
  name        = "WebServer SecGroup"
  description = "My secGroup"

  ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
   }

  ingress {
   from_port   = 443
   to_port     = 443
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
   }

  egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
   }

  tags   = {
   Name  = "Terraform SecGroup"
   Owner = "Sergey Ulikhanyan"
   }
}

