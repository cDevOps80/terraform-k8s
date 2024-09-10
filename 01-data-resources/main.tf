provider "aws" {
  region = "us-east-1"
}

data "ami_id" "amazon-linux" {
  owners           = ["amazon"]
  most_recent      = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.*"]
  }
}

output "amazon-linux-id" {
  value = data.ami_id.amazon-linux.id
}