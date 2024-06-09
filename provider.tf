provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = var.tags
  }
}

provider "kubernetes" {
  host                   = module.compute.eks-cluster-endpoint
  cluster_ca_certificate = base64decode(module.compute.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.eks_auth.token
}

provider "helm" {
  kubernetes {
    host                   = module.compute.eks-cluster-endpoint
    cluster_ca_certificate = base64decode(module.compute.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks_auth.token
  }
}

provider "kubectl" {
  host                   = module.compute.eks-cluster-endpoint
  cluster_ca_certificate = base64decode(module.compute.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.eks_auth.token
  load_config_file       = false
}



terraform {
  backend "s3" {
    bucket  = "dan-glivs"
    key     = "terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.16.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10.0"
    }
  }
}