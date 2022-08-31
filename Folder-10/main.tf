#----------------------------------------------------------
# Provision Highly Available Web in any Region Default VPC
# Create:
#   - SecGroup for Web Server
#   - Launch Config. with Auto AMI Lookup
#   - Auto Scalling Group using 2 Availabilyty Zones
#   - Classic LoadBalancer in 2 Availability Zones
#--------------Made by Sergey Ulikhanyan-------------------

provider "aws" {
  region = "eu-central-1"
}


#----------------------------------------------------------
data "aws_availability_zones" "available" {}
data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}


#----------------------------------------------------------
resource "aws_security_group" "web" {
  name        = "Dynamic SecGroup"

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

  tags    = {
    Name    = "Dynamic SecGroup"
    Owner   = "Sergey Ulikhanyan"
    }
}


#----------------------------------------------------------
resource "aws_launch_configuration" "web" {
  // name         = "WebServer-Highly_Available_LC"
  name_prefix     = "WebServer-Highly-Available-LC-"
  image_id        = data.aws_ami.latest_amazon_linux.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web.id]
  user_data       = file("user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}


#----------------------------------------------------------
resource "aws_autoscaling_group" "web" {
  name                 = "ASG-${aws_launch_configuration.web.name}"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 2
  max_size             = 2
  min_elb_capacity     = 2
  vpc_zone_identifier  = [aws_default_subnet.Default_az_1.id, aws_default_subnet.Default_az_2.id]
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.web.name]
  
  dynamic "tag" {
    for_each   = {
        Name   = "WebServer in ASG"
        Owner  = "Sergey Ulikhanyan"
        TAGKEY = "TAGVALUE"
    }
    content {
        key                 = tag.key
        value               = tag.value
        propagate_at_launch = true
    }
  }
   lifecycle {
     create_before_destroy = true
   }
}


#----------------------------------------------------------
resource "aws_elb" "web" {
  name               = "WebServer-HA-ELB"
  availability_zones = [data.aws_availability_zones.available.names[0],data.aws_availability_zones.available.names[1]]
  security_groups    = [aws_security_group.web.id]
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }
  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }
  tags = {
    Name = "WebServer-Highly-Available-ELB"
  }
}


#----------------------------------------------------------
resource "aws_default_subnet" "Default_az_1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_default_subnet" "Default_az_2" {
  availability_zone = data.aws_availability_zones.available.names[1]
}


#----------------------------------------------------------
output "web_loadbalancer_url" {
  value = aws_elb.web.dns_name
}