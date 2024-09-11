data "external" "final" {
  program = ["bash","${path.module}/run.sh"]
}

#resource "null_resource" "one" {
#  provisioner "local-exec" {
#    command = ["aws","ec2","describe-instance-type-offerings","--region","us-east-1","--location-type","availability-zone" ,"--filters", "Name=instance-type,Values=t3.micro","--output json"]
#  }
#}