data "aws_vpc" "mars-vpc" {
  tags = {
    Name = "project1"
  }
}



resource "aws_instance" "web_server1"{
    ami                         = "ami-06d51e91cea0dac8d"
    instance_type               = "t2.micro"
    key_name                    = "edwin's pair"
    availability_zone           = "us-west-2a"
    subnet_id     = "${aws_subnet.mars-private-1.id}"

    tags     = {
        Name = "WebServer1" 
    }
}

