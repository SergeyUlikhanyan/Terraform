#-------------------------------
#    --- Dynamic SecGroup---
# --Made by Sergey Ulikhanyan--
#-------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "my_SecGroup" {
  name        = "Dynamic SecGroup"
  description = "My secGroup"

dynamic "ingress" {
  for_each = ["80", "443", "8081", "8443"]
  content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  
  ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["10.10.0.0/16"]
   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

  tags    = {
    Name    = "Dynamic SecGroup"
    Owner   = "Sergey Ulikhanyan"
    }
}

