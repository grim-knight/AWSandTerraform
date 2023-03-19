resource "aws_vpc" "new_vpc" {
        cidr_block = "10.0.0.0/16"
        instance_tenancy = "default"
        tags = {
                Name = "w7d2"
        }
}

resource "aws_subnet" "tf-subnet-public"{
	vpc_id = aws_vpc.new_vpc.id
	cidr_block = "10.0.0.0/24"
	map_public_ip_on_launch = "true"
	tags = {
		Name = "Module-tf-subnet-public"
	}
}
