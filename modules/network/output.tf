output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id"
}

output "public_subnets" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.main
}

output "aws_route_table_public" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}



