data "aws_ec2_instance_type_offering" "example" {
  filter {
    name   = "instance-type"
    values = ["t2.micro", "t3.micro"]
  }
}