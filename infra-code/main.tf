module "dev-vpc" {
  source               = "./vpc-module"
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["us-east-1a","us-east-1b"]
  public_cidr_blocks   = ["10.0.1.0/24","10.0.2.0/24"]
  private_cidr_blocks  = ["10.0.3.0/24","10.0.4.0/24"]
  db_cidr_blocks       = ["10.0.5.0/24","10.0.6.0/24"]
}

module "eks" {
  depends_on = [module.dev-vpc]

  source = "./eks-module"
  public_subnets = module.dev-vpc.public_subnets
  private_subnets = module.dev-vpc.private_subnets
}


