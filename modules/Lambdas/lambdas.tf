terraform {
  backend "s3" {
    encrypt = true    
    bucket = "liderapp-tf-state"
    dynamodb_table = "liderapp-tf-state"
    key    = "Lambdas-dynamo/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_dynamodb_table" "items" {
  name           = "Items"
  hash_key       = "id"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role_liderapp"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

  inline_policy {
    name = "lambda_dynamodb_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "dynamodb:PutItem",
            "dynamodb:GetItem"
          ]
          Effect   = "Allow"
          Resource = aws_dynamodb_table.items.arn
        }
      ]
    })
  }
}

resource "aws_lambda_function" "get_item" {
  filename         = "modules/Lambdas/functions/get.zip"
  function_name    = "get_item_function"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "get.lambda_handler"
  runtime          = "python3.9"
}

resource "aws_lambda_function" "post_item" {
  filename         = "modules/Lambdas/functions/post.zip"
  function_name    = "post_item_function"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "post.lambda_handler"
  runtime          = "python3.9"
}

resource "aws_lambda_permission" "get_item_permission" {
  statement_id  = "AllowAPIGatewayInvokeGetItem"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_item.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.items_execution_arn}/*/GET/items/{id}"
}

resource "aws_lambda_permission" "post_item_permission" {
  statement_id  = "AllowAPIGatewayInvokePostItem"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.post_item.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.items_execution_arn}/*/POST/items"
}
