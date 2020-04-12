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

resource "aws_ecr_repository" "experiment_node_example" {
	name = "experiment_node_example"
}

resource "aws_ecs_cluster" "experiment_node_cluster" {
  name = "experiment_node_cluster"
}
