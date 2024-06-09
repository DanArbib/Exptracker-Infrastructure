resource "kubectl_manifest" "app_of_apps" {
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app-of-apps
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  project: default
  source:
    repoURL: 'https://gitlab.com/jenkins3190014/glivs-gitops.git'
    targetRevision: HEAD
    path: infra-apps
  destination:
    name: in-cluster
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
YAML
  depends_on = [
    helm_release.argocd
  ]
}

resource "kubectl_manifest" "application" {
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: glivs
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
  annotations:
    argocd.argoproj.io/sync-wave: "10"
spec:
  project: default
  source:
    repoURL: 'https://gitlab.com/jenkins3190014/glivs-gitops.git'
    targetRevision: HEAD
    path: glivs
    helm:
      valueFiles:
        - values.yaml 
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: app
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - Validate=true
      - CreateNamespace=false
      - PrunePropagationPolicy=foreground
      - PruneLast=true
YAML
  depends_on = [
    helm_release.argocd
  ]
}

