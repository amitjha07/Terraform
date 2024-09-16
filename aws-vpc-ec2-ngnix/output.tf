output "instance_public_ip" {
    description = "The public IP of ec2 instances"
    value = aws_instance.nginx-server.public_ip
  
}
output "instance_url" {
    description = "The URL to access the Nginx serve"
    value = "http://${aws_instance.nginxserver.public_ip}"
  
}