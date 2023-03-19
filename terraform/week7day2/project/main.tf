module "vpc" {
	source = "../modules/vpc"
}


module "ec2"{
	source = "../modules/ec2"
	new_vpc = module.vpc.new_vpc
	tf-subnet-public = module.vpc.tf-subnet-public
}
