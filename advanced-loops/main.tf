#resource "aws_instance" "good" {
#  for_each = var.instance_types
#  ami           = "ami-0a5c3558529277641"
#  instance_type = "t2.micro"
#
#  tags = {
#    Name = "test-${each.key}"
#  }
#}
#
#variable "instance_types" {
#  default = {
#    one = "t2.micro"
#    two = "t2.small"
#  }
#}
#
##output "final" {
##  value = aws_instance.good
##}
#
#output "instance_publicdns2" {
#  value = {
#    for key, myec2vm in aws_instance.good : key => myec2vm.private_ip
#  }
#}
#
#output "instance_publicdns" {
#  value = [ for key, values in aws_instance.good : key  ]
#}
#
#data "aws_availability_zone" "example" {
#  name = "us-east-1a"
#}
#
#output "data" {
#  value = data.aws_availability_zone.example
#}
data "aws_availability_zones" "example" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }

}
output "data" {
  value = data.aws_availability_zones.example.names
}