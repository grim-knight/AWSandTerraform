provider "aws"{
	region = "us-east-1"
}

resource "aws_vpc" "test_vpc_1" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = "true"
	enable_dns_hostnames = "true"
	tags = {
		Name = "test-vpc-1"
	}
}

resource "aws_subnet" "tf-subnet-public-1"{
	vpc_id = aws_vpc.test_vpc_1.id
	cidr_block = "10.0.0.0/24"
	map_public_ip_on_launch = "true"
	#availability_zone = "us-east-1a"
	tags = {
		Name = "tf-subnet-public-1"
	}
}

resource "aws_subnet" "tf-subnet-private-1"{
        vpc_id = aws_vpc.test_vpc_1.id
        cidr_block = "10.0.3.0/24"
        map_public_ip_on_launch = "false"
        #availability_zone = "us-east-1b"
        tags = {
                Name = "tf-subnet-private-1"
        }
}

resource "aws_instance" "ec2"{
	ami = "ami-0aa7d40eeae50c9a9"
	instance_type = "t2.micro"
	tags = {
		Name = "tf-instance-trial"
		vpc_id = aws_vpc.test_vpc_1.id
    		subnet_id = aws_subnet.tf-subnet-private-1.id
	}
}
