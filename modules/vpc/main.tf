# ------------------------------
# VPC
# ------------------------------
resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "${var.app_name}-${var.environment}-vpc"
  }
}

# ------------------------------
# Subnets
# ------------------------------
resource "aws_subnet" "public-subnet-a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_block_az_a
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.app_name}-${var.environment}-public-subnet-a"
  }
}

resource "aws_subnet" "public-subnet-c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_block_az_c
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.app_name}-${var.environment}-public-subnet-c"
  }
}

# ------------------------------
# Route Tables
# ------------------------------
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "${var.app_name}-${var.environment}-public-route"
  }
}

resource "aws_route_table_association" "public-subnet-a" {
  subnet_id      = aws_subnet.public-subnet-a.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public-subnet-c" {
  subnet_id      = aws_subnet.public-subnet-c.id
  route_table_id = aws_route_table.public-route.id
}

# ------------------------------
# Internet Gateway
# ------------------------------
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.app_name}-${var.environment}-internet-gateway"
  }
}
