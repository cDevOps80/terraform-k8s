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

  owners      = ["RHEL-9-DevOps-Practice"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
#    filter {
#      name   = "architecture"
#      values = ["arm64"]
#    }

}



output "amazon-linux-id" {
  value = data.aws_ami_ids.example
}