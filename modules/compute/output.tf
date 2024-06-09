output "nodes_group_id" {
  value       = aws_eks_node_group.nodes_group.id
  description = "Node group id"
}

output "eks-cluster-endpoint" {
  value       = aws_eks_cluster.eks.endpoint
  description = "EKS endpoint"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.eks.certificate_authority[0].data
  description = "EKS certificate authority data"
}

output "cluster_name" {
  value       = aws_eks_cluster.eks.name
  description = "EKS token"
}
