data "aws_vpc" "default" {
  default = true
}

data "aws_key_pair" "example" {
  filter {
    name   = "key-name"
    values = ["nvirginia"]
  }
}

output "data-key" {
  value = data.aws_key_pair.example.public_key
}

#resource "aws_instance" "one" {
#  ami  = "ami-0a5c3558529277641"
#  instance_type = "t2.micro"
#  vpc_security_group_ids = []
#}