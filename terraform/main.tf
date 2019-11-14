provider "aws" {
  region  = "us-west-2"
}

terraform {
  backend "s3" {
    region         = "us-west-2"
    bucket         = "cit480mars"
    key            = "project1/terraform.tfstate"
    dynamodb_table = "mars-state-lock"
  }
}

