provider "aws" {
  region = "us-east-1"
}

#data "ami_id" "amazon-linux" {
#  owners           = ["amazon"]
#  most_recent      = true
#
#  filter {
#    name   = "name"
#    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240903.0-x86_64-gp2"]
#  }
#
#  filter {
#    name   = "architecture"
#    values = ["x86_64"]
#  }
#}
#
#output "amazon-linux-id" {
#  value = data.ami_id.amazon-linux.id
#}