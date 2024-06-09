# Secret manager
data "aws_secretsmanager_secret" "secrets" {
  arn = var.secrets_arn
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

locals {
  secrets_json = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)
}

# Create namespaces
resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = "app"
  }
}

resource "kubernetes_namespace" "db_namespace" {
  metadata {
    name = "db"
  }
}

resource "kubernetes_namespace" "external-dns_namespace" {
  metadata {
    name = "external-dns"
  }
}

resource "kubernetes_namespace" "logging_namespace" {
  metadata {
    name = "logging"
  }
}

# Secret for application
resource "kubectl_manifest" "secrets-application" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: secrets-application
  namespace: ${var.app_secrets_namespace}
type: Opaque
data:
  flask_secret_key: ${base64encode(local.secrets_json["FLASK_SECRET_KEY"])}
  jwt_secret_key: ${base64encode(local.secrets_json["JWT_SECRET_KEY"])}
  postgres_user_password: ${base64encode(local.secrets_json["POSTGRES_USER_PASSWORD"])}
YAML

  depends_on = [
    var.nodes_group_id,
    kubernetes_namespace.app_namespace
  ]
}

# Secret for database
resource "kubectl_manifest" "secrets-pg" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: secrets-pg
  namespace: ${var.db_secrets_namespace}
type: Opaque
data:
  postgres_database_name: ${base64encode(local.secrets_json["POSTGRES_DB"])}
  postgres_user: ${base64encode(local.secrets_json["POSTGRES_USER"])}
  postgres_user_password: ${base64encode(local.secrets_json["POSTGRES_USER_PASSWORD"])}
  postgres_admin_password: ${base64encode(local.secrets_json["POSTGRES_ADMIN_PASSWORD"])}  
YAML

  depends_on = [
    var.nodes_group_id,
    kubernetes_namespace.db_namespace
  ]
}

# Secret for cloudflare
resource "kubectl_manifest" "cloudflare-api-key" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: cloudflare
  namespace: external-dns
type: Opaque
data:
  apiKey: ${base64encode(local.secrets_json["CF_API_TOKEN"])}
YAML

  depends_on = [
    var.nodes_group_id,
    kubernetes_namespace.external-dns_namespace
  ]
}

# Secret for cloudflare
resource "kubectl_manifest" "elasticsearch" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: elasticsearch
  namespace: logging
type: Opaque
data:
  elasticsearch-password: ${base64encode(local.secrets_json["elasticPassword"])}
  kibana-password: ${base64encode(local.secrets_json["elasticPassword"])}
YAML

  depends_on = [
    var.nodes_group_id,
    kubernetes_namespace.external-dns_namespace
  ]
}
