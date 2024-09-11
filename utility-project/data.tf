variable "av_zones" {
  default = ["us-east-1a","us-east-1b"]
}

data "aws_ec2_instance_type_offering" "example" {
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

output "finale" {
  value = data.aws_ec2_instance_type_offering.example.*.instance_type
}