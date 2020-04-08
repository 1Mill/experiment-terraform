provider "aws" {
	profile			= "terraform"
	region 			= "us-east-1"
	shared_credentials_file	= "/root/.aws"
	version 		= "~> 2.56"
}

resource "aws_instance" "example" {
	ami			= "ami-2757f631"
	instance_type 		= "t2.micro"
}
