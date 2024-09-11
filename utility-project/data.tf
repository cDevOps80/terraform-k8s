data "aws_ec2_instance_type_offering" "example" {
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = ["us-east-1a"]
  }

  location_type = "availability-zone"
}

output "finale" {
  value = data.aws_ec2_instance_type_offering.example.instance_type
}