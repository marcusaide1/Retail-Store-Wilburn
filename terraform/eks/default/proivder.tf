provider "aws" {
  region = "us-east-1"
}

# Kubernetes provider for your EKS cluster
provider "kubernetes" {
  host                   = module.retail_app_eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.retail_app_eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

# Helm provider pointing to the same Kubernetes cluster
provider "helm" {
  kubernetes {
    host                   = module.retail_app_eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.retail_app_eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

