terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "chaituample"
    key = "dev/mysql"
  }
}



resource "null_resource" "mysql" {
provisioner "local-exec" {
  command = "echo this is mysql"
}
}