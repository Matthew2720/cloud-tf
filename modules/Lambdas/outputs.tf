output "get_item_lambda" {
  value = aws_lambda_function.get_item.invoke_arn
  description = "Lambda Get function"
}

output "post_item_lambda" {
  value = aws_lambda_function.get_item.invoke_arn
  description = "Lambda Get function"
}