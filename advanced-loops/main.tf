resource "aws_instance" "good" {
  for_each = var.instance_types
  ami           = "ami-0a5c3558529277641"
  instance_type = "t2.micro"

  tags = {
    Name = "test-${each.key}"
  }
}

variable "instance_types" {
  default = {
    one = "t2.micro"
    two = "t2.small"
  }
}

output "final" {
  value = aws_instance.good
}

output "instance_publicdns2" {
  value = {
    for  myec2vm in aws_instance.good : myec2vm.availability_zone => myec2vm.public_dns
  }
}