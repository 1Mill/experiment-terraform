resource "aws_lambda_permission" "apigw" {
	action = "lambda:InvokeFunction"
	function_name = aws_lambda_function.example.function_name
	principal = "apigateway.amazonaws.com"
	source_arn = "${aws_api_gateway_rest_api.example.execution_arn}/*/*"
	statement_id = "AllowAPIGatewayInvoke"
}
