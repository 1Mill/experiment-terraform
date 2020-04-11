resource "aws_api_gateway_deployment" "example" {
	depends_on = [
		aws_api_gateway_integration.lambda,
		aws_api_gateway_integration.lambda_root,
	]

	rest_api_id = aws_api_gateway_rest_api.example.id
	state_name = "test"
}
