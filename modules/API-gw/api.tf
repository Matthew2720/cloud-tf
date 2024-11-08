resource "aws_api_gateway_rest_api" "items_api" {
  name        = "Items API"
  description = "API Gateway for Items service"
}

resource "aws_api_gateway_resource" "items" {
  rest_api_id = aws_api_gateway_rest_api.items_api.id
  parent_id   = aws_api_gateway_rest_api.items_api.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_resource" "item" {
  rest_api_id = aws_api_gateway_rest_api.items_api.id
  parent_id   = aws_api_gateway_resource.items.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "get_item_method" {
  rest_api_id   = aws_api_gateway_rest_api.items_api.id
  resource_id   = aws_api_gateway_resource.item.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "post_item_method" {
  rest_api_id   = aws_api_gateway_rest_api.items_api.id
  resource_id   = aws_api_gateway_resource.items.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_item_integration" {
  rest_api_id             = aws_api_gateway_rest_api.items_api.id
  resource_id             = aws_api_gateway_resource.item.id
  http_method             = aws_api_gateway_method.get_item_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_item_lambda
}

resource "aws_api_gateway_integration" "post_item_integration" {
  rest_api_id             = aws_api_gateway_rest_api.items_api.id
  resource_id             = aws_api_gateway_resource.items.id
  http_method             = aws_api_gateway_method.post_item_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.post_item_lambda
}

resource "aws_api_gateway_deployment" "items_api_deployment" {
  depends_on = [
    aws_api_gateway_integration.get_item_integration,
    aws_api_gateway_integration.post_item_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.items_api.id
  stage_name  = "prod"
}
