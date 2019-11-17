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

//resource "aws_s3_bucket" "cit480mars" {
//  bucket = "cit480mars" 

// versioning {
//    enabled = true
//  }

//  lifecycle {
//    prevent_destroy = true
//  }
//}

//resource "aws_dynamodb_table" "mars-state-lock" {
//  name            = "tf-state-lock" 
//  hash_key        = "LockID"
//  read_capacity   = 20
//  write_capacity = 20

//  attribute {
//    name = "LockID"
//    type = "S"
//  }

//  tags {
//    Name = "DynamoDB tf state locking"
//  }
//} 

