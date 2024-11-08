output "public_subnet_1a" {
  value = aws_subnet.public_subnet_1a.id
}

output "public_subnet_1b" {
  value = aws_subnet.public_subnet_1b.id
}

output "vpc" {
    value = aws_vpc.main.id
}
