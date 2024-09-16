terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}
resource "aws_instance" "first_server" {
    ami = "ami-0e53db6fd757e38c7"
    instance_type = "t2.micro"
  tags = {
    Name="sampleServer"
  }
}
