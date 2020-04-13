// API Gateway
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

resource "aws_api_gateway_deployment" "example" {
	depends_on = [
		aws_api_gateway_integration.lambda,
		aws_api_gateway_integration.lambda_root,
	]

	rest_api_id = aws_api_gateway_rest_api.example.id
	stage_name = "test"
}

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

// Lambda
resource "aws_lambda_function" "example" {
	function_name = "ServerlessExample"
	handler = "index.handler"
	role = aws_iam_role.lambda_exec.arn
	runtime = "nodejs12.x"
	s3_bucket = "experiment-terraform-serverless"
	s3_key = "v${var.app_version}/example.zip"
}

resource "aws_lambda_permission" "apigw" {
	action = "lambda:InvokeFunction"
	function_name = aws_lambda_function.example.function_name
	principal = "apigateway.amazonaws.com"
	source_arn = "${aws_api_gateway_rest_api.example.execution_arn}/*/*"
	statement_id = "AllowAPIGatewayInvoke"
}

// Roles
resource "aws_iam_role" "lambda_exec" {
	name = "serverless_example_lambda"
	assume_role_policy = <<EOF
{
	"Statement": [
		{
			"Action": "sts:AssumeRole",
			"Effect": "Allow",
			"Principal": {
				"Service": "lambda.amazonaws.com"
			},
			"Sid": ""
		}
	],
	"Version": "2012-10-17"
}
	EOF
}
