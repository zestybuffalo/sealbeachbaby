resource "aws_ecs_cluster" "overhead-cluster" {
    name = "overhead-cluster"
}
resource "aws_launch_configuration" "ecs-overhead-launchconfig" {
  name_prefix          = "ecs-overhead-launchconfig"
  image_id             = "${lookup(var.ECS_AMIS, var.AWS_REGION)}"
  key_name             = "${aws_key_pair.mykeypair.key_name}"
  instance_type        = "${var.ECS_INSTANCE_TYPE}"  
  security_groups      = ["${aws_security_group.surflineusa-securitygroup.id}"]
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=overhead-cluster' > /etc/ecs/ecs.config\nstart ecs"
  lifecycle              { create_before_destroy = true }
}
