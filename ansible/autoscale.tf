#autoscale resources

resource "aws_launch_configuration" "project1-launchconfig" {
    name_prefix             = "mars-launchconfig"
    image_id                = "webserver"  #Needs to change to the hugo server once made
    instance_type           = "t2.micro"
    key_name                = "edwin's key"
    security_groups         = ["${aws_security_group.allow-tls.id}"]  
}
resource "aws_autoscaling_group" "project1-autoscale" {
  name                      = "project1-autoscale"
  vpc_zone_identifier       = ["${aws_subnet.mars-private-1.id}","${aws_subnet.mars-private-2.id}"]
  launch_configuration      = "${aws_launch_configuration.project1-launchconfig}"
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  tags = {
      key = "Name"
      value = "ec2 instance"
      propagate_at_launch = true
  }
}

