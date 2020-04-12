
data "aws_iam_role" "ecs_task_execution_role" {
	name = "ecsTaskExecutionRole"
}

resource "aws_ecs_cluster" "experiment_node_cluster" {
	name = "experiment_node_cluster"
}

resource "aws_ecs_task_definition" "expeirment_node_task" {
	container_definitions = <<DEFINITION
[
	{
		"cpu": 256,
		"essential": true,
		"image": "${aws_ecr_repository.experiment_node_example.repository_url}",
		"memory": 512,
		"name": "expeirment_node_task",
		"portMappings": [
			{
				"containerPort": 3000,
				"hostPort": 3000
			}
		]
	}
]
DEFINITION
	cpu = 256
	execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
	family = "expeirment_node_task"
	memory = 512
	network_mode = "awsvpc"
	requires_compatibilities = ["FARGATE"]
}
