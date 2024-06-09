resource "aws_eks_cluster" "eks" {
  name     = "${var.eks_cluster_name}_cluster-${terraform.workspace}"
  role_arn = aws_iam_role.dan_glivs_cluster.arn
  version  = "1.29"

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    subnet_ids              = var.public_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy,
    aws_iam_role_policy_attachment.service_policy
  ]
}