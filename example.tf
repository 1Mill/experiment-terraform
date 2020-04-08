provider "aws" {
	profile		= "defualt"
	region 		= "us-east-1"
	version 	= "~> 2.56"
}

resource "aws_instance" "example" {
	aim 		= "ami-2757f631"
	instance_type 	= "t2.micro"
}
