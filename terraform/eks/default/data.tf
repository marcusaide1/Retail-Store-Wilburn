# -----------------------------------------------------------------------------
# EKS Cluster Authentication
# -----------------------------------------------------------------------------
data "aws_eks_cluster_auth" "this" {
  name = module.retail_app_eks.eks_cluster_id
}

# -----------------------------------------------------------------------------
# Query the UI service deployed via Helm
# -----------------------------------------------------------------------------
data "kubernetes_service" "ui_service" {
  depends_on = [helm_release.ui] # ensures the service exists first

  metadata {
    name      = "ui"
    namespace = "ui"
  }
}

