resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id = aws_vpc.main.id
  availability_zone = "us-east-2a"
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id = aws_vpc.main.id
  availability_zone = "us-east-2b"
  cidr_block = "10.0.2.0/24"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.main.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "public_asoc_1a" {
    subnet_id = aws_subnet.public_subnet_1a.id
    route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "public_asoc_1b" {
    subnet_id = aws_subnet.public_subnet_1b.id
    route_table_id = aws_route_table.rt_public.id
}

resource "aws_eip" "nat" {}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1a.id

  tags = {
    Name = "NAT GW 1a"
  }
}

# resource "aws_route_table_association" "private_asoc_1a" {
#     subnet_id = aws_subnet.private_subnet_1a.id
#     route_table_id = aws_route_table.rt_private.id
# }

# resource "aws_route_table_association" "private_asoc_1b" {
#     subnet_id = aws_subnet.private_subnet_1b.id
#     route_table_id = aws_route_table.rt_private.id
# }