resource "aws_instance" "bastion"{
    ami                         = "ami-06d51e91cea0dac8d"
    instance_type               = "t2.micro"
    key_name                    = "hugo.key"
    availability_zone           = "us-west-2a"
    subnet_id                   = "${aws_subnet.mars-public-1.id}"
    private_ip                  = "10.10.96.15"
    


    tags     = {
        Name = "project1-bastion" 
    }
}