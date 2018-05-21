output "elb" {
  value = "${aws_elb.aws_elb_name.dns_name}"
}
output "jenkins" {
  value = "${aws_instance.jenkins-instance.public_ip}"
}
output "ecr-repository-URL" {
  value = "${aws_ecr_repository.ecr_repo_name.repository_url}"
}
