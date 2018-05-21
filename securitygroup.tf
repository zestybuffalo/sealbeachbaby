resource "aws_security_group" "resourcename-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name = "name1_SG"
  description = "security group for ecs"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 3000
      to_port = 3000
      protocol = "tcp"
      security_groups = ["${aws_security_group.SG_name-elb-securitygroup.id}"]
  } 
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  tags {
    Name = "ecs"
  }
}
resource "aws_security_group" "resource_name-elb-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name = "resource_name-elb"
  description = "security group for ecs"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  tags {
    Name = "resource_name-elb"
  }
}
# jenkins
resource "aws_security_group" "jenkins-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name = "jenkins-securitygroup"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
tags {
    Name = "jenkins-securitygroup"
  }
}
