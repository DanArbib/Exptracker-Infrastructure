variable "eks_cluster_name" {
  description = "EKS cluster name"
}

variable "nodes_group_id" {
  description = "Node group"
}

variable "ingress_nginx_repo" {
  description = "Ingress nginx repo"
  type        = string
}

variable "ingress_nginx_chart" {
  description = "Ingress nginx chart"
  type        = string
}

variable "ingress_nginx_namespace" {
  description = "Ingress nginx namespace"
}

variable "ingress_nginx_version" {
  description = "Ingress nginx version"
}

variable "argocd_repo" {
  description = "Argocd repo"
  type        = string
}

variable "argocd_chart" {
  description = "Argocd chart"
  type        = string
}

variable "argocd_namespace" {
  description = "Argocd namespace"
  type        = string
}

variable "argocd_version" {
  description = "Argocd version"
  type        = string
}

variable "secrets_arn" {
  description = "Secrets arn"
  type        = string
}

variable "argocd_ingress_enabled" {
  description = "Argocd ingress enabled"
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
  type        = string
}

variable "app_secrets_namespace" {
  description = "Secrets namespace for app"
  type        = string
}

variable "db_secrets_namespace" {
  description = "Secrets namespace for database"
  type        = string
}
