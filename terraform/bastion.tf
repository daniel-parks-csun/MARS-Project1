resource "aws_instance" "bastion"{
    ami                         = "ami-09edc878bb0dfe351"  #Bastion Image
    instance_type               = "t2.micro"
    key_name                    = "dp.cory"
    availability_zone           = "us-west-2a"
    subnet_id                   = "${aws_subnet.mars-public-1.id}"
    private_ip                  = "10.10.96.15"
    security_groups             = ["${aws_security_group.allow-ssh.id}"]
    


    tags     = {
        Name = "project1-bastion" 
    }
}