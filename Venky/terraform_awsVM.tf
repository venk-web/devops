#Successful code for AWS VM creation:

#provider.tf
provider "aws" {
    region = var.vpc_region
}
terraform {
  backend "s3" {
    bucket = "devvbuck"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

#ec2.tf
resource "aws_instance" "web" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.dev_subnets.*.id[0]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  key_name = "novkey"
  tags = {
    Name = "myvm"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]     #All 0's means allowing all traffic
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]     #All 0's means allowing all traffic
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]     #All 0's means allowing all traffic
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my_security_group"
  }
}

#networking.tf

resource "aws_vpc" "dev_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "myvpc"
    }
}

resource "aws_subnet" "dev_subnets" {
    vpc_id = aws_vpc.dev_vpc.id
    count = length(var.vpc_subnets)
    cidr_block = var.vpc_subnets[count.index]
    availability_zone = local.az_names[count.index]
}


#To converti above private IP into public IP:
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "mygateway"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "myrouteTable"
  }
}

#subnet association
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.dev_subnets.*.id[0]
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.dev_subnets.*.id[0]
  route_table_id = aws_route_table.main.id
}


#variable.tf
variable "vpc_cidr" {
  default = "10.3.3.0/24"
}

variable "vpc_subnets" {
  default = ["10.3.3.0/25",  "10.3.3.128/25"]
}

variable "vpc_region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-01816d07b1128cd2d"
}

variable "instance_type" {
  default = "t2.micro"
}


#test.tfvars:
vpc_cidr = "10.3.5.0/24"
vpc_subnets = ["10.3.5.0/25",  "10.3.5.128/25"]
instance_type = "t2.micro"


#data.tf
data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_caller_identity" "account_id_print" {
  
}


#output.tf
output "id_output" {
  value = aws_vpc.dev_vpc.id
}

output "account_id_print" {
  value = local.acc_id
}


#locals.tf
locals {
  az_names = data.aws_availability_zones.azs.names
  acc_id = data.aws_caller_identity.account_id_print
}
