#VPC
resource "aws_vpc" "mars-vpc" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "project1-vpc"
  }
}

#Subnets
resource "aws_subnet" "mars-public-1" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.0.0/19"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2a"
  tags = {
    Name = "public-subnet-1"
    tier = "public"
  }
}

resource "aws_subnet" "mars-public-2" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.32.0/19"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2b"
  tags = {
    Name = "public-subnet-2"
    tier = "public"
  }
}

resource "aws_subnet" "mars-public-3" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.64.0/19"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2c"
  tags = {
    Name = "public-subnet-3"
    tier = "public"
  }
}

resource "aws_subnet" "mars-private-1" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.96.0/21"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2a"
  tags = {
    Name = "private-subnet-1"
    tier = "private"
  }
}

resource "aws_subnet" "mars-private-2" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.104.0/21"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2b"
  tags = {
    Name = "private-subnet-2"
    tier = "private"
  }
}

resource "aws_subnet" "mars-private-3" {
  vpc_id                  = aws_vpc.mars-vpc.id
  cidr_block              = "10.10.112.0/21"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2c"
  tags = {
    Name = "private-subnet-3"
    tier = "private"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "mars-gateway" {
  vpc_id = aws_vpc.mars-vpc.id

  tags = {
    Name = "mars-gateway"
  }
}

#Route tables
resource "aws_route_table" "mars-public" {
  vpc_id = aws_vpc.mars-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mars-gateway.id
  }
  tags = {
    Name = "Mars-Public"
  }
}

# Route associations public
resource "aws_route_table_association" "mars-public-1-a" {
  subnet_id      = aws_subnet.mars-public-1.id
  route_table_id = aws_route_table.mars-public.id
}

resource "aws_route_table_association" "mars-public-2-a" {
  subnet_id      = aws_subnet.mars-public-2.id
  route_table_id = aws_route_table.mars-public.id
}

resource "aws_route_table_association" "mars-public-3-a" {
  subnet_id      = aws_subnet.mars-public-3.id
  route_table_id = aws_route_table.mars-public.id
}


