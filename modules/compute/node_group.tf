resource "aws_eks_node_group" "nodes_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.eks_cluster_name}-node-group-${terraform.workspace}"

  node_role_arn = aws_iam_role.nodes_role.arn
  subnet_ids    = var.public_subnets

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  ami_type             = var.ami_type
  capacity_type        = var.capacity_type
  disk_size            = var.disk_size
  force_update_version = var.force_update_version
  instance_types       = var.instance_types
  labels               = var.labels

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
    aws_eks_cluster.eks
  ]
}