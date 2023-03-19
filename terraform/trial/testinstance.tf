provider "aws"{
	region = "us-east-1"
}

resource "aws_instance" "test_inst_1" {
	ami = "ami-0aa7d40eeae50c9a9"
	instance_type = "t2.micro"
}
