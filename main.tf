
# Network module
module "network" {
  source                  = "./modules/network"
  eks_cluster_name        = var.eks_cluster_name
  available_zones         = data.aws_availability_zones.available_zones.names
  vpc_cidr_block          = var.vpc_cidr_block
  enable_dns_support      = var.enable_dns_support
  enable_dns_hostnames    = var.enable_dns_hostnames
  public_subnet_count     = var.public_subnet_count
  public_subnet_bits      = var.public_subnet_bits
  map_public_ip_on_launch = var.map_public_ip_on_launch
}

# Compute module
module "compute" {
  source               = "./modules/compute"
  depends_on           = [module.network]
  eks_cluster_name     = var.eks_cluster_name
  eks_cluster_version  = var.eks_cluster_version
  ami_type             = var.ami_type
  capacity_type        = var.capacity_type
  disk_size            = var.disk_size
  force_update_version = var.force_update_version
  instance_types       = var.instance_types
  desired_size         = var.desired_size
  max_size             = var.max_size
  min_size             = var.min_size
  labels               = var.labels

  # Inputs from network module
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets
}

# Helm module
module "helm" {
  source                  = "./modules/helm"
  eks_cluster_name        = var.eks_cluster_name
  ingress_nginx_repo      = var.ingress_nginx_repo
  ingress_nginx_chart     = var.ingress_nginx_chart
  ingress_nginx_namespace = var.ingress_nginx_namespace
  ingress_nginx_version   = var.ingress_nginx_version
  argocd_repo             = var.argocd_repo
  argocd_chart            = var.argocd_chart
  argocd_namespace        = var.argocd_namespace
  argocd_version          = var.argocd_version
  secrets_arn             = var.secrets_arn

  argocd_ingress_enabled = var.argocd_ingress_enabled
  argocd_domain          = var.argocd_domain
  gitops_repo_url        = var.gitops_repo_url
  gitops_repo_name       = var.gitops_repo_name
  app_secrets_namespace  = var.app_secrets_namespace
  db_secrets_namespace   = var.db_secrets_namespace

  # Inputs from compute module
  nodes_group_id = module.compute.nodes_group_id
}