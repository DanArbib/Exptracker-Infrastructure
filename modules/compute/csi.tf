resource "aws_eks_addon" "aws_ebs_csi_driver" {
  cluster_name      = aws_eks_cluster.eks.name
  addon_name        = "aws-ebs-csi-driver"
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    aws_eks_cluster.eks
  ]
}