provider "aws" {
	region = "us-east-1"
}

resource "aws_s3_bucket" "bucket1"{
	bucket = "s3bucket-tf"
	acl = "public-read"
}

resource "aws_s3_bucket_object" "object"{
	bucket = aws_s3_bucket.bucket1.id
	key = "profile"
	acl = "public-read"
	source = "/home/ec2-user/terraform/s3bucket/terraform.tfstate"
	
}
