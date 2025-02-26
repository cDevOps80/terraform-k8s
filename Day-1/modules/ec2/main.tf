terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "chaituample"
    key = "dev/ec2"
  }
}




resource "null_resource" "main" {

  provisioner "local-exec" {
    command = "echo this is provisioner-1"
  }
}

output "ec2_module1" {
  value = "chaitu"
}

output "ec2_module2" {
  value = "ec2_module2"
}