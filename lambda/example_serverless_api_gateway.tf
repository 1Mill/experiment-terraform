resource "aws_api_gateway_rest_api" "example" {
	description = "Terraform Serverless Application Example"
	name = "ServerlessExample"
}

resource "aws_api_gateway_resource" "proxy" {
	parent_id = aws_api_gateway_rest_api.example.root_resource_id
	rest_api_id = aws_api_gateway_rest_api.example.id

	path_part = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
	resource_id = aws_api_gateway_resource.proxy.id
	rest_api_id = aws_api_gateway_rest_api.example.id

	authorization = "NONE"
	http_method = "ANY"
}
