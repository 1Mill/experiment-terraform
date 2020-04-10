terraform {
	backend "s3" {
		bucket			= "experiment-terraform-state"
		dynamodb_table		= "experiment-terraform-state-locks"
		encrypt			= true
		key			= "global/s3/terraform.tfstate"
		profile			= "terraform"
		region			= "us-east-1"
		shared_credentials_file	= "/root/.aws"
	}
}

provider "aws" {
	profile			= "terraform"
	region 			= "us-east-1"
	shared_credentials_file	= "/root/.aws"
	version 		= "~> 2.56"
}

resource "aws_instance" "example" {
	// ami		= "ami-2757f631"
	ami		= "ami-b374d5a5"
	instance_type	= "t2.micro"
}
