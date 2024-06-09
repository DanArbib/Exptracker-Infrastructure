# VPC
resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.eks_cluster_name}-vpc-${terraform.workspace}"
  }
}

resource "aws_default_security_group" "main" {
  vpc_id = aws_vpc.main.id
}


# Subnets (Public)
resource "aws_subnet" "public" {
  count = var.public_subnet_count

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, var.public_subnet_bits, count.index)
  availability_zone       = var.available_zones[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch 

  tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}_cluster-${terraform.workspace}" = "owned"
    "kubernetes.io/role/elb"                                                       = "1"
    Name                                                                           = "${var.eks_cluster_name}-public-subnet-${count.index + 1}-${terraform.workspace}"
  }
}

# IGW
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.eks_cluster_name}-igw-${terraform.workspace}"
  }
}

# Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.eks_cluster_name}-rt-${terraform.workspace}"
  }
}

# Public Route Table rules
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}

# Public Route table associations
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

