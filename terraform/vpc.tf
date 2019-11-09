provider "aws" {
 region = "us-west-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Mars-VPC"
  cidr = "10.10.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.10.0.0/19", "10.10.32.0/19", "10.10.64.0/19"]
  public_subnets  = ["10.10.96.0/21", "10.10.104.0/21", "10.10.128.0/21"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
                      
