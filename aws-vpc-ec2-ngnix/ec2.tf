resource "aws_instance" "nginx-server" {
    ami = "ami-0e53db6fd757e38c7"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnate.id
    vpc_security_group_ids = [ aws_security_group.ng-sg.id ]
    associate_public_ip_address = true
    user_data = <<-EOF
        #!/bin/bash
        sudo yum install nginx -y
        sudo systemctl start nginx
     EOF
  tags = {
    Name="ngnix-server"
  }
}