data "aws_availability_zones" "available_zones" {
  state = "available"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = module.compute.cluster_name
}