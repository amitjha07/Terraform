terraform {
  required_providers {
    aws = {
         source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}
data "aws_ami" "name" {
  most_recent = true
  owners = [ "amazon" ]
}
data "aws_security_group" "name" {
  tags = {
    ng-sg="http"
  }
}
data "aws_vpc" "name" {
  tags = {
    ENV="PROD"
    Name="my_vpc"
  }
}
output "aws_vpc" {
  value = data.aws_vpc.name.id
}
output "aws_security_group" {
  value = data.aws_security_group.name.id
}
output "aws_ami" {
  value = data.aws_ami.name.id
}
resource "aws_instance" "first_server" {
    ami = "ami-0e53db6fd757e38c7"
    instance_type = "t2.micro"
   
  tags = {
    Name="sampleServer"
  }
}