
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}
variable "ECS_AMIS" {
  type = "map"
  default = {
    us-east-2 = "ami-1b90a67e"
    us-west-2 = "ami-05b5277d"
    us-east-1 = "ami-cb17d8b6"
  }
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-97785bed"
    us-west-2 = "ami-f2d3638a"
    us-east-2 = "ami-f63b1193"
  }
}
variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
variable "JENKINS_VERSION" {
  default = "2.107.2"
}
