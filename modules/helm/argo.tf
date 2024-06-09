resource "helm_release" "argocd" {
  name = var.argocd_namespace

  repository       = var.argocd_repo
  chart            = var.argocd_chart
  namespace        = var.argocd_namespace
  version          = var.argocd_version
  create_namespace = true

  # Argocd admin password config
  set_sensitive {
    name  = "configs.secret.argocdServerAdminPassword"
    value = bcrypt(local.secrets_json.argocd_admin_password)
  }

  # Ingress config
  set {
    name  = "server.ingress.enabled"
    value = var.argocd_ingress_enabled
  }

  set {
    name  = "server.ingress.ingressClassName"
    value = var.ingress_nginx_namespace
  }

  set {
    name  = "global.domain"
    value = var.argocd_domain
  }

  # Gitlab repo config
  set_sensitive {
    name  = "configs.repositories.helm-repo.password"
    value = local.secrets_json.gitlab_token
  }

  set_sensitive {
    name  = "configs.repositories.helm-repo.username"
    value = local.secrets_json.gitlab_user
  }

  set {
    name  = "configs.repositories.helm-repo.url"
    value = var.gitops_repo_url
  }

  set {
    name  = "configs.repositories.helm-repo.name"
    value = var.gitops_repo_name
  }
}