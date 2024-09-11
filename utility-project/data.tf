#variable "av_zones" {
#  default = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d","us-east-1e","us-east-1f"]
#}
#
#data "aws_ec2_instance_type_offerings" "example" {
#  count = length(var.av_zones)
#  filter {
#    name   = "instance-type"
#    values = ["t2.micro"]
#  }
#  filter {
#    name   = "location"
#    values = ["${var.av_zones[count.index]}"]
#  }
#
#  location_type = "availability-zone"
#}
#
#output "final" {
# # value = data.aws_ec2_instance_type_offerings.example.*.instance_types
#  value = keys({
#    for i, value in data.aws_ec2_instance_type_offerings.example:
#        "${var.av_zones[i]}" => value.instance_types if length(value.instance_types) > 0
#  })
#}
#
##locals {
##  one = tomap(keys({
##    for i, value in data.aws_ec2_instance_type_offerings.example:
##    "${var.av_zones[i]}" => value.instance_types if length(value.instance_types) > 0
##  }))
##}
#
#resource "aws_instance" "sample1" {
#  for_each = toset(keys({
#    for i, value in data.aws_ec2_instance_type_offerings.example:
#    "${var.av_zones[i]}" => value.instance_types if length(value.instance_types) > 0
#  }))
#  ami           = "ami-0a5c3558529277641"
#  instance_type = "t3.micro"
#  availability_zone = each.key
#}


resource "one" "sample" {
  provisioner "local-exec" {
    command = "bash run.sh"
  }
}