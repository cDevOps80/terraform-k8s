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
    values = ["amzn2-ami-kernel-5.10-hvm-*.0.20240903.0-*-gp2"]

#    amzn2-ami-kernel-5.10-hvm-2.0.20240903.0-x86_64-gp2
#
#amzn2-ami-kernel-5.10-hvm-2.0.20240903.0-arm64-gp2
    #amzn2-ami-kernel-5.10-hvm-*.0.20240903.0-*-gp2
  }
    filter {
      name   = "architecture"
      values = ["x86_64"]
    }
}

output "final" {
  value = data.aws_ami_ids.example
}



