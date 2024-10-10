# Provider
# Defines the AWS provider and the region where the resources will be deployed.
provider "aws" {
  access_key = "AWS_ACCESS_KEY"
  secret_key = "AWS_SECRET_KEY"
  region     = var.region
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true           
  enable_dns_hostnames = true       # resolve names to IP 
  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Public Subnets
# Allow the instance to access internet
resource "aws_subnet" "public_subnet" {
  count                   = 2 # one for each az, high availability
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-public-subnet-${count.index}"
  }

}

# Private Subnets
# For RDS Mysql resource that don't required direct access to the internet
resource "aws_subnet" "private_subnet" {
  count             = 2 #  one for each az, high availability
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "${var.environment}-private-subnet-${count.index}"
  }
}

# Internet Gateway
# Allows the instance in the public subnets to access the internet.
resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-internet-gateway"
  }
}

# Public Route table
# A route to send traffic to the internet throw internet gateway
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" # all traffic

    gateway_id = aws_internet_gateway.internet.id
  }
  tags = {
    Name = "${var.environment}-public-route"
  }
}

# Associate Route table
resource "aws_route_table_association" "public_route_table_association" {
  count          = 2
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}
