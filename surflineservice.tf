data "template_file" "surfline-task-definition-template" {
  template               = "${file("templates/app.json.tpl")}"
  vars {
    REPOSITORY_URL = "${replace("${aws_ecr_repository.surflineusa.repository_url}", "https://", "")}"
    APP_VERSION = "${var.MYAPP_VERSION}" 
 }
}

resource "aws_ecs_task_definition" "surfline-task-definition" {
  family                = "surfline"
  container_definitions = "${data.template_file.surfline-task-definition-template.rendered}"

}

resource "aws_elb" "surfline-elb" {
  name = "surfline-elb"

  listener {
    instance_port = 3000
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 30
    target = "HTTP:3000/"
    interval = 60
  }

  subnets = ["${aws_subnet.main-public-1.id}}"]
  security_groups = ["${aws_security_group.surflineusa-elb-securitygroup.id}"]

}

