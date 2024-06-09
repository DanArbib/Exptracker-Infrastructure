# Main
tags = {
  Owner           = "dan.arbib"
  expiration_date = "30-05-24"
  bootcamp        = 20
}

# Network
vpc_cidr_block          = "10.0.0.0/16" # 16 bits network portion
enable_dns_support      = true          # Allows instances within the VPC to communicate using domain names
enable_dns_hostnames    = true          # Allows instances within the VPC to be accessed by their hostname
public_subnet_count     = 3             # Number of subnets
public_subnet_bits      = 4             # Bits to calculate unique CIDR block for each subnet
map_public_ip_on_launch = true          # Indicate that instances launched into the subnet should be assigned a public IP address.

# EKS
eks_cluster_name     = "dan"  # Cluster name
eks_cluster_version  = "2.17"       # Kubernetes version
ami_type             = "AL2_x86_64" #  Type of Amazon Machine, valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
capacity_type        = "ON_DEMAND"  #SPOT
disk_size            = 20           # Disk space size
force_update_version = false        # Force version update if existing pods are unable to be drained due to a pod disruption budget issue
instance_types       = ["t3a.large"]# Instance types
desired_size         = 3 # Desired number of worker nodes
max_size             = 3 # Maximum number of worker nodes
min_size             = 2 # Minimum number of worker nodes
labels = {
  role = "nodes-general"
}

# Helm secret manager
secrets_arn = "arn:aws:secretsmanager:ap-south-1:644435390668:secret:prod/dan/gilvs-2p33eI"

# Helm ingress nginx
ingress_nginx_repo      = "https://kubernetes.github.io/ingress-nginx"
ingress_nginx_chart     = "ingress-nginx"
ingress_nginx_namespace = "nginx"
ingress_nginx_version   = "4.10.0"

# Helm argocd
argocd_repo      = "https://argoproj.github.io/argo-helm"
argocd_chart     = "argo-cd"
argocd_namespace = "argocd"
argocd_version   = "7.0.0"
argocd_ingress_enabled = true
argocd_domain          = "argocd.glivs.com"
gitops_repo_url        = "https://gitlab.com/jenkins3190014/glivs-gitops.git"
gitops_repo_name       = "glivs"

# Secrets
app_secrets_namespace = "app"
db_secrets_namespace  = "app"
