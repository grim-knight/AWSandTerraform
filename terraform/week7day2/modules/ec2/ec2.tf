resource "aws_instance" "ec2test"{
        ami = "ami-0aa7d40eeae50c9a9"
        instance_type = "t2.micro"
	subnet_id = "${var.tf-subnet-public}"
        tags = {
                Name = "Module-created-ec2"
		vpc_id = var.new_vpc
        }
} 
