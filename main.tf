terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAT4EDDZXUORGWFYMW"
  secret_key = "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"
}

resource "aws_vpc" "crazyeatsvpc" {
   cidr_block = "172.10.0.0/16"
   tags = {
     Name = "creazyeats-vpc"
   }
}

variable "az" {
  default = {
    a = "ap-south-1a"
  }
}
  
resource "aws_subnet" "creazyeatspubsubnet" {
  vpc_id = aws_vpc.crazyeatsvpc.id
  availability_zone = var.az.a
  cidr_block = "172.10.1.0/24"
  tags = {
    Name = "crazyeats-pub-subnet1"
  }
}

resource "aws_internet_gateway" "creazyeatsig" {
  vpc_id = aws_vpc.crazyeatsvpc.id
  tags = {
    Name = "crazyeats-ig"
  }
}

resource "aws_route_table" "crazyeatsigrt" {
  vpc_id = aws_vpc.crazyeatsvpc.id
  tags = {
    Name = "crazyeats-igrt"
  }

 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.creazyeatsig.id
 }

}

resource "aws_route_table_association" "crazyeatsrtass" {
  route_table_id = aws_route_table.crazyeatsigrt.id
  subnet_id = aws_subnet.creazyeatspubsubnet.id
}
  
resource "aws_security_group" "crazyeatssshsg" {
  vpc_id = aws_vpc.crazyeatsvpc.id
  name = "crazyeats-securitygroups"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "crazyeats-sg"
  }
 
}
 

resource "aws_instance" "crazyeatsec2" {
  subnet_id = aws_subnet.creazyeatspubsubnet.id
  vpc_security_group_ids = ["${aws_security_group.crazyeatssshsg.id}"]
  associate_public_ip_address = true
  ami = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro" 

  tags = {
    Name = "crazyeatsec2"
  }

}