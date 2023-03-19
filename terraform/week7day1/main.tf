provider "aws"{
	region = "us-east-1"
}

data "aws_instance" "private-sagar"{
	instance_id = var.private-sagar-id
}


resource "aws_instance" "ec2"{
	ami = data.aws_instance.private-sagar.ami
	instance_type = data.aws_instance.private-sagar.instance_type
	vpc_security_group_ids = data.aws_instance.private-sagar.vpc_security_group_ids
	subnet_id = data.aws_instance.private-sagar.subnet_id 
}


output "private-sagar"{
	value = "${data.aws_instance.private-sagar}"
}
