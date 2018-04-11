resource "aws_s3_bucket" "demo" {
  bucket = "my-demo-bucket"
  acl    = "private"

  tags {
    Name        = "My demo bucket"
  }
}
