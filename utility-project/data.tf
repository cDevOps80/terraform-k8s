data "external" "final" {
  program = ["aws","ec2","describe-instance-type-offerings","--region","us-east-1","--location-type","availability-zone" ,"--filters", "Name=instance-type,Values=t3.micro","--output json"]
}
