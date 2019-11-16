# TERRAFORM

### _main.tf_:

* Sets region to _us-west-2_
* References the location of S3 bucket to keep the state.


### _vpc.tf_:

* Creates AWS VPC of 10.10.0.0/16
* Enables DNS support 
* sets a tag of _project1-vpc_.
* Creates 3 public subnets and 3 private subnets.
* Creates Internet Gateway and attaches to VPC.
* Creates a routing table and associates all public subnets to it.


### _nat.tf_:

* Leases Elastic IP
* Creates NAT Gateway
* Sets tag to _Mars-Nat_
* Creates a routing table, attaches VPC and NAT Gateway.
* Associates all private subnets to the routing table.


### _elb.tf_:

* Creates an ELB that sits in 2 availability zones: mars-private-1 amd mars-private-2
* Sets port listeners on port 80 & 443.
* Attaches SSL Cert to Port 443.


### _autoscale.tf_:

* Creates new EC2 when CPU goes 20% over the threshold.


### _bastion.tf_:

* Uses custom ami to create bastion instance that already has Fail2ban

### _securitygroup.tf_:

* Allows outgoing http connections. 
* Allows incomming https connections.
* Allows incoming and outgoing ssh connections to destination of 10.10.96.15.


