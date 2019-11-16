# TERRAFORM

## VPC

### _VPC.tf_:

* Creates AWS VPC of 10.10.0.0/16
* Enables DNS support 
* sets a tag of _project1-vpc_.
* Creates 3 public subnets and 3 private subnets.
* Creates Internet Gateway and attaches to VPC.
* Creates a routing table and associates all public subnets to it.

