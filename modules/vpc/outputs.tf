output "vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnets"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "List of private subntes"
  value       = aws_subnet.private_subnet[*].id
}

output "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  value       = aws_subnet.private_subnet[*].cidr_block
}