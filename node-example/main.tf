
data "aws_iam_role" "ecs_task_execution_role" {
	name = "ecsTaskExecutionRole"
}

resource "aws_ecs_cluster" "experiment_node_cluster" {
	name = "experiment_node_cluster"
}

resource "aws_ecs_service" "experiment_node_service" {
	cluster = aws_ecs_cluster.experiment_node_cluster.id
	desired_count = 3
	launch_type = "FARGATE"
	name = "experiment_node_service"
	task_definition = aws_ecs_task_definition.expeirment_node_task.arn

	network_configuration {
		assign_public_ip = true
		subnets = [
			aws_default_subnet.default_subnet_a,
			aws_default_subnet.default_subnet_b,
			aws_default_subnet.default_subnet_c
		]
	}
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
	execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
	family = "expeirment_node_task"
	memory = 512
	network_mode = "awsvpc"
	requires_compatibilities = ["FARGATE"]
}
