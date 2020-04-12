
data "aws_iam_role" "ecs_task_execution_role" {
	name = "ecsTaskExecutionRole"
}

resource "aws_ecs_cluster" "experiment_node_cluster" {
	name = "experiment_node_cluster"
}

resource "aws_ecs_service" "experiment_node_service" {
	cluster = aws_ecs_cluster.experiment_node_cluster.id
	desired_count = 1
	launch_type = "FARGATE"
	name = "experiment_node_service"
	task_definition = aws_ecs_task_definition.expeirment_node_task.arn

	load_balancer {
		container_name = aws_ecs_task_definition.expeirment_node_task.family
		container_port = 3000
		target_group_arn = aws_lb_target_group.target_group.arn
	}

	network_configuration {
		assign_public_ip = true
		subnets = [
			aws_default_subnet.default_subnet_a.id,
			aws_default_subnet.default_subnet_b.id,
			aws_default_subnet.default_subnet_c.id
		]
		security_groups = [ aws_security_group.service_security_group.id ]
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

resource "aws_security_group" "service_security_group" {
	egress {
		cidr_blocks = [ "0.0.0.0/0" ]
		from_port = 0
		protocol = "-1"
		to_port = 0
	}

	ingress {
		from_port = 0
		protocol = "-1"
		to_port = 0
		security_groups = [ aws_security_group.load_balancer_security_group.id ]
	}
}
