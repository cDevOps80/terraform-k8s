provider "aws" {
  region = "us-east-1"
}



#data "aws_ami" "example" {
#  most_recent      = true
#  owners           = ["amazon"]
#    filter {
#      name   = "name"
#      values = ["amzn2-ami-kernel-5.10-hvm-2.*"]
#    }
#
#  filter {
#    name   = "architecture"
#    values = ["arm64"]
#  }
#}

data "aws_ami_ids" "example" {

  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240903.0-x86_64-gp2"]
  }
}



output "amazon-linux-id" {
  value = data.aws_ami_ids.example
}