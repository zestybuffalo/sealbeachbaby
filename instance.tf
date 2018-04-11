provider "aws" {
  region     = "us-east-1"
} 

resource "aws_instance" "example" {
  ami           = "ami-5cd4a126"
  instance_type = "t2.micro"
}

# Internet VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "main"
    }
}

# Subnets
resource "aws_subnet" "subnet-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "subnet-1"
    }
}
