
data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "chaituample"
    key    = "dev/ec2"
    region = "us-east-1"
  }
}



resource "null_resource" "mysql" {
  triggers = {
    date = timestamp()
  }
provisioner "local-exec" {
  command = "echo this is mysql -- ${data.terraform_remote_state.ec2.outputs.name}  ${data.terraform_remote_state.ec2.outputs.name} "
}
}