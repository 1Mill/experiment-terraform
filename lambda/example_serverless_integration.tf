resource "aws_api_gateway_integration" "lambda" {
	http_method = aws_api_gateway_method.proxy.http_method
	resource_id = aws_api_gateway_method.proxy.resource_id
	rest_api_id = aws_api_gateway_rest_api.example.id

	integration_http_method = "POST"
	type = "AWS_PROXY"
	uri = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_integration" "lambda_root" {
	http_method = aws_api_gateway_method.proxy_root.http_method
	resource_id = aws_api_gateway_method.proxy_root.resource_id
	rest_api_id = aws_api_gateway_rest_api.example.id

	integration_http_method = "POST"
	type = "AWS_PROXY"
	uri = aws_lambda_function.example.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root" {
	resource_id = aws_api_gateway_rest_api.example.root_resource_id
	rest_api_id = aws_api_gateway_rest_api.example.id

	authorization = "NONE"
	http_method = "ANY"
}
