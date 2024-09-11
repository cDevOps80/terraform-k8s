variable "av_zones" {
  default = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d","us-east-1e","us-east-1f"]
}

data "aws_ec2_instance_type_offerings" "example" {
  count = length(var.av_zones)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = ["${var.av_zones[count.index]}"]
  }

  location_type = "availability-zone"
}

output "final" {
 # value = data.aws_ec2_instance_type_offerings.example.*.instance_types
  value = keys({
    for i, value in data.aws_ec2_instance_type_offerings.example:
        "${var.av_zones[i]}" => value.instance_types if length(value.instance_types) > 0
  })
}