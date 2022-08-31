
output "webserver_info" {
  value = [aws_instance.my_Web_Server.id,
  aws_eip.MyStaticIP.public_ip,
  aws_security_group.my_SecGroup.arn
  ]
}
