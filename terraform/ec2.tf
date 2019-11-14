
resource "aws_instance" "web_server1"{
    ami                         = "ami-06d51e91cea0dac8d"
    instance_type               = "t2.micro"
    key_name                    = "edwin's key"
    availability_zone           = "us-west-2a"
    subnet_id     = "${aws_subnet.mars-private-1.id}"

    tags     = {
        Name = "WebServer1" 
    }
}

resource "aws_instance" "web_server2"{
    ami                         = "ami-06d51e91cea0dac8d"
    instance_type               = "t2.micro"
    key_name                    = "edwin's key"
    availability_zone           = "us-west-2b"
    subnet_id     = "${aws_subnet.mars-private-2.id}"

    tags     = {
        Name = "WebServer2" 
    }
}

resource "aws_instance" "web_server3"{
    ami                         = "ami-06d51e91cea0dac8d"
    instance_type               = "t2.micro"
    key_name                    = "edwin's key"
    availability_zone           = "us-west-2c"
    subnet_id     = "${aws_subnet.mars-private-3.id}"

    tags     = {
        Name = "WebServer3" 
    }
}