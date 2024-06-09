variable "eks_cluster_name" {
  description = "EKS cluster name"
}

variable "available_zones" {
  description = "Available zones"
}

variable "map_public_ip_on_launch" {
  description = "Public ip"
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

variable "enable_dns_support" {
  description = "DNS support"
}

variable "enable_dns_hostnames" {
  description = "dns hostnames"
}

variable "public_subnet_count" {
  type        = number
  description = "Number of Public subnets."
}

variable "public_subnet_bits" {
  type        = number
  description = "Number of additional bits with which to extend the prefix."
}
