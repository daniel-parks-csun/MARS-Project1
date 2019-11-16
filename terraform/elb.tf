#ELB

resource "aws_elb" "project1-elb" {
    name            = "project1-elb"
    internal        = false
    subnets         = ["${aws_subnet.mars-private-1.id}","${aws_subnet.mars-private-2.id}"] 
    security_groups = ["${aws_security_group.allow-tls.id}"]
    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    listener {
        instance_port     = 443
        instance_protocol = "https"
        lb_port           = 443
        lb_protocol       = "https"
        ssl_certificate_id = "arn:aws:acm:us-west-2:490411576806:certificate/c2c5057c-da75-4e17-9f05-a659a7cf4f90" 
        }

    health_check{
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:80/"
        interval            = 30
    }  


cross_zone_load_balancing   = true
connection_draining         = true
connection_draining_timeout = 400
tags = {
    Name = "project1-elb"
}
}

data "aws_route53_zone" "mars" {
    name           = "cit480mars.net"
    private_zone   = false
}

resource "aws_route53_record" "build" {
    provider       = "aws"
    zone_id        = "${data.aws_route53_zone.mars.zone_id}"
    name           = "cit480mars.net"
    type           = "A"
  
  alias {
      name                   = "${aws_elb.project1-elb.dns_name}"
      zone_id                = "${aws_elb.project1-elb.zone_id}"
      evaluate_target_health = false
  }
}
resource "aws_route53_record" "build2" {
    provider       = "aws"
    zone_id        = "${data.aws_route53_zone.mars.zone_id}"
    name           = "www"
    type           = "CNAME"
  
  alias {
      name                   = "${aws_elb.project1-elb.dns_name}"
      zone_id                = "${aws_elb.project1-elb.zone_id}"
      evaluate_target_health = false
  }

}
