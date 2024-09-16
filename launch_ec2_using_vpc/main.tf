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
#create a VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name ="my_vpc"
    }
  
}
#private subnate
resource "aws_subnet" "private_subnate" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name="private-subnate"
  }
}
#public subnate
resource "aws_subnet" "public_subnate" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name="public-subnate"
  }
}
#Intergent gateway
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name ="my-igw"
    }
  
}
#Routing Table
resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.my_vpc.id
  route  {
    cidr_block="0.0.0.0/0"
    gateway_id =aws_internet_gateway.my-igw.id
  }
}
resource "aws_route_table_association" "public-sub" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.private_subnate.id
  
}
resource "aws_instance" "first_server" {
    ami = "ami-0e53db6fd757e38c7"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnate.id
  tags = {
    Name="sampleServer"
  }
}
