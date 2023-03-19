variable "azs"{
	description = "availability zones"
	type = list
}
variable "pubsubCIDRblock"{
	description = "public subnet list"
	type = list
}
variable "privsubCIDRblock"{
	description = "private subnet list"
	type = list
}
variable "vpc_cidr"{
	type = string
}
