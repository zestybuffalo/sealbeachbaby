output "elb" {
  value = "${aws_elb.surfline-elb.dns_name}"
}
output "jenkins" {
  value = "${aws_instance.jenkins-instance.public_ip}"
}
output "ecr-repository-URL" {
  value = "${aws_ecr_repository.surflineusa.repository_url}"
}
