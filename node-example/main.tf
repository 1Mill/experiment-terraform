
data "aws_iam_role" "ecs_task_execution_role" {
	name = "ecsTaskExecutionRole"
}

resource "aws_ecs_cluster" "experiment_node_cluster" {
  name = "experiment_node_cluster"
}

resource "aws_ecs_task_definition" "expeirment_node_task" {
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
	cpu = 256
	execution_role_arn = ${data.aws_iam_role.ecs_task_execution_role.arn}
	family = "experiment_node_task"
	memory = 512
	network_mode = "awsvpc"
	requries_compatabilities = ["FARGATE"]
}
