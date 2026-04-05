provider "aws" {
  region = "us-east-1"
}

module "prod_vpc" {
  source   = "./modules"
  vpc_name = "Saireddy-Prod-Network"
}
