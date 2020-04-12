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

resource "aws_ecs_task_definition" "expeirment_node_task" {
	family = "experiment_node_task"
	container_definitions = <<DEF
[
	{
		"cpu": 256,
		"essential": true,
		"image": "${aws_ecr_repository.experiment_node_example.repository_url}",
		"memory": 512,
		"name: "experiment_node_task",
		"portMappings": [
			{
				"containerPort": 3000,
				"hostPort": 3000
			}
		]
	}
]
DEF
	requries_compatabilities = ["FARGATE"]
	network_mode = "awsvpc"
	memory = 512
	cpu = 256
	execution_role_arn = ${data.aws_iam_role.ecs_task_execution_role.arn}
}

resource "aws_iam_role" "ecs_task_execution_role" {
	name = "ecsTaskExecutionRole"
}
