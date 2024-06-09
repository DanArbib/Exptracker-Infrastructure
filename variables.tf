
##### Main
variable "tags" {
  description = "Tags"
  type        = map(string)
}

##### Network
variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
  type        = string
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable DNS support in the VPC."
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
}

variable "public_subnet_count" {
  type        = number
  default     = 3
  description = "Number of Public subnets."
}

variable "public_subnet_bits" {
  type        = number
  default     = 4
  description = "Number of additional bits with which to extend the prefix."
}

variable "map_public_ip_on_launch" {
  type        = bool
  default     = true
  description = "map_public_ip_on_launch."
}

##### EKS
variable "eks_cluster_name" {
  default     = "cluster"
  type        = string
  description = "EKS cluster name"
}

variable "eks_cluster_version" {
  default     = "2.17"
  type        = string
  description = "EKS cluster version"
}

variable "ami_type" {
  default     = "ON_DEMAND"
  type        = string
  description = "Type of Amazon Machine"
}

variable "capacity_type" {
  default     = "ON_DEMAND"
  type        = string
  description = "Capacity type on demand or spot"
}

variable "disk_size" {
  type        = number
  default     = 20
  description = "Disk size"
}

variable "force_update_version" {
  type        = bool
  default     = false
  description = " Force version update if existing pods are unable"
}

variable "instance_types" {
  default     = ["t3a.medium"]
  description = "Instance types"
}

variable "desired_size" {
  type        = number
  default     = 2
  description = "Desired number of worker nodes"
}

variable "max_size" {
  type        = number
  default     = 2
  description = "Maximum number of worker nodes"
}

variable "min_size" {
  type        = number
  default     = 2
  description = "Minimum number of worker nodes"
}

variable "labels" {
  description = "Nodes labels"
  type        = map(string)
  default = {
    role = "nodes-general"
  }
}

##### Helm
variable "ingress_nginx_repo" {
  description = "Ingress nginx rep"
  default     = "https://kubernetes.github.io/ingress-nginx"
  type        = string
}

variable "ingress_nginx_chart" {
  description = "Ingress nginx chart"
  default     = "ingress-nginx"
  type        = string
}

variable "ingress_nginx_namespace" {
  description = "Ingress nginx namespace"
  default     = "nginx"
  type        = string
}

variable "ingress_nginx_version" {
  description = "Ingress nginx version"
  default     = "4.10.0"
  type        = string
}

variable "argocd_repo" {
  description = "Argocd repo"
  default     = "https://argoproj.github.io/argo-helm"
  type        = string
}

variable "argocd_chart" {
  description = "Argocd chart"
  default     = "argo-cd"
  type        = string
}

variable "argocd_namespace" {
  description = "Argocd namespace"
  default     = "argocd"
  type        = string
}

variable "argocd_version" {
  description = "Argocd version"
  default     = "7.0.0"
  type        = string
}

variable "secrets_arn" {
  description = "Secrets arn"
  type        = string
}

variable "argocd_ingress_enabled" {
  description = "Argocd ingress enabled"
  default     = true
  type        = bool
}

variable "argocd_domain" {
  description = "Argocd domain"
  type        = string
}

variable "gitops_repo_url" {
  description = "Gitops repo url"
  type        = string
}

variable "gitops_repo_name" {
  description = "Gitops repo name"
  default     = "gitops"
  type        = string
}

variable "app_secrets_namespace" {
  description = "Secrets namespace for app"
  default     = "app"
  type        = string
}

variable "db_secrets_namespace" {
  description = "Secrets namespace for database"
  default     = "db"
  type        = string
}

