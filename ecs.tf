resource "aws_ecs_cluster" "name" {
    name = "clustername"
}
resource "aws_launch_configuration" "ecs-clustername-launchconfig" {
  name_prefix          = "ecs-clustername-launchconfig"
  image_id             = "${lookup(var.ECS_AMIS, var.AWS_REGION)}"
  key_name             = "${aws_key_pair.mykeypair.key_name}"
  instance_type        = "${var.ECS_INSTANCE_TYPE}"  
  security_groups      = ["${aws_security_group.sgname-securitygroup.id}"]
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=cluster_name-cluster' > /etc/ecs/ecs.config\nstart ecs"
  lifecycle              { create_before_destroy = true }
}
