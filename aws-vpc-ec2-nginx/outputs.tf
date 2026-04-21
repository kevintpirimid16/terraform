output "publicIp" {
  description = "Nginx server public ip"
  value = aws_instance.nginx-server.public_ip
}
output "instanceUrl" {
  description = "Nginx server Url"
  value = "http://${aws_instance.nginx-server.public_ip}"
}