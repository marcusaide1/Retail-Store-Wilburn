# ---------------------------------------------------------------------
# AWS Provider
# ---------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

# ---------------------------------------------------------------------
# Kubernetes Provider (uses EKS cluster from module.retail_app_eks)
# ---------------------------------------------------------------------
provider "kubernetes" {
  host                   = module.retail_app_eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.retail_app_eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token  # uses existing data.tf resource
}

# ---------------------------------------------------------------------
# Helm Provider (uses same Kubernetes cluster)
# ---------------------------------------------------------------------
provider "helm" {
  kubernetes {
    host                   = module.retail_app_eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.retail_app_eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.this.token  # uses existing data.tf resource
  }
}

