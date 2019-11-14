#nat gw

resource "aws_eip" "mars-nat" {
    vpc = true  
}

resource "aws_nat_gateway" "mars-nat-gw" {
    allocation_id = aws_eip.mars-nat.id
    subnet_id     = aws_subnet.mars-public-1.id
    depends_on    = ["aws_internet_gateway.mars-gateway"] 
    tags = {
        Name = "Mars-Nat"
    }   
}

resource "aws_route_table" "mars-private" {
    vpc_id   = aws_vpc.mars-vpc.id
    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.mars-nat-gw.id
    }
  tags = {
      Name = "Mars-Private"
  }
}

#route associations private

resource "aws_route_table_association" "mars-private-1-a" {
    subnet_id = aws_subnet.mars-private-1.id
    route_table_id  = aws_route_table.mars-private.id  
}
resource "aws_route_table_association" "mars-private-2-a" {
    subnet_id = aws_subnet.mars-private-2.id
    route_table_id  = aws_route_table.mars-private.id  
}
resource "aws_route_table_association" "mars-private-3-a" {
    subnet_id = aws_subnet.mars-private-3.id
    route_table_id  = aws_route_table.mars-private.id  
}



