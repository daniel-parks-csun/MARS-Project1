
#VPC
resource "aws_vpc" "mars-vpc" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "project1"
  }
}

#Subnets

resource "aws_subnet" "mars-private-1" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.0.0/19"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2a"
  tags = {
    Name = "private_tag"
    tier = "private_subnet_1"
  }
}

resource "aws_subnet" "mars-private-2" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.32.0/19"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2b"
  tags = {
    Name = "private_tag"
    tier = "private_subnet_2"
  }
}

resource "aws_subnet" "mars-private-3" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.64.0/19"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2c"
  tags = {
    Name = "private_tag"
    tier = "private_subnet_3"
  }
}

resource "aws_subnet" "mars-public-1" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.96.0/21"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2a"
  tags = {
    Name = "public_tag"
    tier = "public_subnet_1"
  }
}

resource "aws_subnet" "mars-public-2" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.104.0/21"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2b"
  tags = {
    Name = "public_tag"
    tier = "public_subnet_2"
  }
}

resource "aws_subnet" "mars-public-3" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.112.0/21"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2c"
  tags = {
    Name = "public_tag"
    tier = "public_subnet_3"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "mars-gateway" {
  vpc_id = aws_vpc.mars-vpc.id

  tags = {
    Name = "ig_tag"
  }
}
