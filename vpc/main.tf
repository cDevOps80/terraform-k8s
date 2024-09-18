module "dev-vpc" {
  source               = "./vpc-module"
  availability_zones   = ["us-east-1a","us-east-1b"]
  public_cidr_blocks   = ["10.0.1.0/24","10.0.2.0/24"]
  private_cidr_blocks  = ["10.0.3.0/24","10.0.4.0/24"]
  db_cidr_blocks       = ["10.0.5.0/24","10.0.6.0/24"]
}


