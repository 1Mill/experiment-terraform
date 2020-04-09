provider "aws" {
	profile			= "terraform"
	region 			= "us-east-1"
	shared_credentials_file	= "/root/.aws"
	version 		= "~> 2.56"
}

resource "aws_s3_bucket" "terraform_state" {
	bucket = "experiment-terraform-state"

	versioning {
		enabled = true
	}

	server_side_encryption_configuration {
		rule {
			apply_server_side_encryption_by_default {
				sse_algorithm = "AES256"
			}
		}
	}
}
