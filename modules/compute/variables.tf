variable "eks_cluster_name" {
  description = "EKS cluster name"
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
}

variable "ami_type" {
  description = "Type of Amazon Machine"
}

variable "capacity_type" {
  description = "Capacity type on demand or spot"
}

variable "disk_size" {
  description = "Disk size"
}

variable "force_update_version" {
  description = " Force version update if existing pods are unable"
}

variable "instance_types" {
  description = "Instance types"
}

variable "desired_size" {
  description = "Desired number of worker nodes"
}

variable "max_size" {
  description = "Maximum number of worker nodes"
}

variable "min_size" {
  description = "Minimum number of worker nodes"
}

variable "labels" {
  description = "Nodes labels"
}

# Network input
variable "vpc_id" {
  description = "Vpc id"
}

variable "public_subnets" {
  description = "public subnets"
}




