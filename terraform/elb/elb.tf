provider "aws" {
	region = "us-east-1"
}

resource "aws_elb" "elb"{
	name = "tf-elb"
	availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
	listener {
		instance_port     = 8000
    		instance_protocol = "http"
    		lb_port           = 80
    		lb_protocol       = "http"
	}
}
