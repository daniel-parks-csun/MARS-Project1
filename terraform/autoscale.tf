#autoscale resources

resource "aws_launch_configuration" "project1-launchconfig" {
    name_prefix             = "mars-launchconfig"
    image_id                = "ami-02fee746d0aeb7342"  #Needs to change to the hugo server once made
    instance_type           = "t2.micro"    
    key_name                = "hugo.key"
    security_groups         = ["${aws_security_group.allow-tls.id}"]  
}
#ScaleUp
resource "aws_autoscaling_group" "project1-autoscale" {
  name                      = "project1-autoscale"
  vpc_zone_identifier       = ["${aws_subnet.mars-private-1.id}","${aws_subnet.mars-private-2.id}"]
  launch_configuration      = "${aws_launch_configuration.project1-launchconfig.name}"
  min_size                  = 2
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "ELB" 
  load_balancers            = ["${aws_elb.project1-elb.name}"]
  force_delete              = true

  tag {
   key = "Name"
   value = "Pj1HugoServer"
   propagate_at_launch = true
  }
}
#Autoscale Policy
resource "aws_autoscaling_policy" "project1-cpu-policy" {
  name                   = "project1-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.project1-autoscale.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
  
}
#Alarm
resource "aws_cloudwatch_metric_alarm" "project-mars-alarm" {
  alarm_name            = "project1-cpu-alarm"
  alarm_description     = "Cpu Alarm for Project 1"
  comparison_operator   = "GreaterThanOrEqualToThreshold"
  evaluation_periods    = "2"
  metric_name           = "CPUUtilization"
  namespace             = "AWS/EC2"
  period                = "120"
  statistic             = "Average"
  threshold             = "30"

  dimensions = {
    "AutoScalingGroupName" = "aws_autoscaling_group.project1-autoscale.name"
  }
  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.project1-cpu-policy.arn}"]
}

#Scaledown
resource "aws_autoscaling_policy" "project1-cpu-policy-down" {
  name                   = "project1-cpu-policy-down"
  autoscaling_group_name = aws_autoscaling_group.project1-autoscale.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-11"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
  
}
#Alarm
resource "aws_cloudwatch_metric_alarm" "project-mars-downalarm" {
  alarm_name            = "project1-cpu-downalarm"
  alarm_description     = "Cpu Alarm for Project 1"
  comparison_operator   = "LessThanOrEqualToThreshold"
  evaluation_periods    = "2"
  metric_name           = "CPUUtilization"
  namespace             = "AWS/EC2"
  period                = "120"
  statistic             = "Average"
  threshold             = "5"

  dimensions = {
    "AutoScalingGroupName" = "aws_autoscaling_group.project1-autoscale.name"
  }
  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.project1-cpu-policy-down.arn}"]
}

#Simple notification service

resource "aws_sns_topic" "project1-cpu-sns" {
  name         = "project1-cpu-sns"
  display_name = "Project1 ASG SNS topic"  
} #sent up in console

#Attach SNS to autoscale Group

resource "aws_autoscaling_notification" "project1-notify" {
  group_names   = ["${aws_autoscaling_group.project1-autoscale.name}"]
  topic_arn     = "${aws_sns_topic.project1-cpu-sns.arn}"
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]  
}


