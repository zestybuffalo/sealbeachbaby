resource "aws_security_group" "surflineusa-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name = "surflineusa"
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
      security_groups = ["${aws_security_group.surflineusa-elb-securitygroup.id}"]
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
resource "aws_security_group" "surflineusa-elb-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name = "surflineusa-elb"
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
    Name = "surflineusa-elb"
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
