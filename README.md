# MARS-Project1
CIT480 Project 1 - MARS Group


This is our project for CIT480.  All the files are in the terraform folder.  

vpc.tf
This will create a 10.10.0.0/16 VPC and 3 public /19 networks and 3 private /21 networks.  It will attach all the public subnets to an internet gateway and generate route tables that allow all traffic.  Then it will associate the subnets to that route table.

nat.tf
This will allocate a elastic Ip and then attach it to a nat-gateway.  It will then create a route table that will allow outbound network traffic but only internal inbound traffic. It then associates all the private subnets to this table.

securitygroups.tf 
Creates 2 security groups. allow=tls will allow 80/443 inbound and outbound.  Will only allow 22 from the statically assign bastion IP address. 

main.tf
Selects the provider and names the s3 bucket that contains the state lock.  It also contains the comments out code that created the bucket.

elb.tf
Creates a elb and opens listening ports on 80 and 443 it allows cross zone balancing and generates an A record and a cname record in route 53.

bastion.tf
This creates a bastion jumpbox in the first public subnet and statically assigns it an IP address.  It also attaches a AWS public key to it.

autoscale.tf
This code deploys 2 hugo servers into the first 2 private subnets basied on a AMI create to server a hugo webserver.  It assigns the ELB to perform a health check.  It then defines a autoscaling policy that will spin up additonal EC2 instances if the CPU is 30 or higher.  It will then scale down when the CPU goes below 5.  It also creates Alarms for when this happens creates an SNS notification service and attaches it to the autoscaling group.
