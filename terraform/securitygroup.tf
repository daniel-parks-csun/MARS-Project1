#Securtiy Groups
#allow https

resource "aws_security_group" "allow-tls" {
    name         = "project1-public"
    description  = "Allows 443"
    vpc_id       = "${aws_vpc.mars-vpc.id}"

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
     }  

     egress {
         from_port = 80
         to_port   = 80
         protocol  = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
     }

     ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["10.10.0.15/32"]
     }  
     
     egress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["10.10.0.15/32"]
     }  
}

#allow ssh

resource "aws_security_group" "allow-ssh" {
    name         = "project1-ssh"
    description  = "Allows ssh"
    vpc_id       = "${aws_vpc.mars-vpc.id}"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
     }

     egress {
         from_port = 0
         to_port   = 0
         protocol  = "-1"
         cidr_blocks = ["0.0.0.0/0"]
     }  
}





