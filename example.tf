terraform {
	required_version = "~> 0.12.24"

	backend "s3" {
		bucket = "experiment-terraform-state"
		dynamodb_table = "experiment-terraform-state-locks"
		encrypt = true
		key = "global/s3/terraform.tfstate"
		profile = "terraform"
		region = "us-east-1"
		shared_credentials_file = "/root/.aws"
	}
}

provider "aws" {
	profile = "terraform"
	region = "us-east-1"
	shared_credentials_file = "/root/.aws"
	version = "~> 2.56"
}

// resource "aws_instance" "example" {
// 	// ami = "ami-2757f631"
// 	ami = "ami-b374d5a5"
// 	instance_type	= "t2.micro"
// }

resource "aws_lambda_function" "example" {
	function_name = "ServerlessExample"
	handler = "index.handler"
	role = aws_iam_role.lambda_exec.arn
	runtime = "nodejs12.x"
	s3_bucket = "experiment-terraform-serverless"
	s3_key = "v0.0.1/example.zip"
}

resource "aws_iam_role" "lambda_exec" {
	name = "serverless_example_lambda"
	assume_role_policy = <<EOF
		{
			"Statement": [
				{
					"Action": "sts:AssumeRole",
					"Effect": "Allow",
					"Principal": {
						"Service": "lambda.amazonaws.com"
					},
					"Sid": ""
				}
			],
			"Version": "2012-10-17"
		}
	EOF
}
