# TERRAFORM

## VPC

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



### _autoscale.tf_:



### _bastion.tf_:


### _securitygroup.tf_:
