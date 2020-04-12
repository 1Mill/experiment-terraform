resource "aws_alb" "application_load_balancer" {
	load_balancer_type = "application"
	name = "experiment-node-load-balancer"
	security_groups = [
		aws_security_group.load_balancer_security_group.id
	]
	subnets = [
		aws_default_subnet.default_subnet_a.id,
		aws_default_subnet.default_subnet_b.id,
		aws_default_subnet.default_subnet_c.id
	]
}

resource "aws_security_group" "load_balancer_security_group" {
	egress {
		cidr_blocks = [ "0.0.0.0/0" ]
		from_port = 0
		protocol = "-1"
		to_port = 0
	}

	ingress {
		cidr_blocks = [ "0.0.0.0/0" ]
		from_port = 80
		protocol = "tcp"
		to_port = 80
	}
}
