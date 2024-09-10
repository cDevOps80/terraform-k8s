resource "aws_instance" "good" {
  for_each = var.instance_types
  ami           = "ami-0a5c3558529277641"
  instance_type = "t2.micro"

  tags = {
    Name = "test-${each.key}"
  }
}

variable "instance_types" {
  one = "t2.micro"
  two = "t2.small"
}

output "final" {
  value = aws_instance.good
}