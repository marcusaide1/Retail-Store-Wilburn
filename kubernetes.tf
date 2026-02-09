# -----------------------------------------------------------------------------
# Kubernetes Namespace
# -----------------------------------------------------------------------------
resource "kubernetes_namespace_v1" "retail_app" {
  metadata {
    name = "retail-app"
    labels = {
      "project" = "bedrock"
    }
  }
}

# -----------------------------------------------------------------------------
# Helm Deployment - AWS Retail Store Sample App (CORE REQUIREMENT)
# -----------------------------------------------------------------------------
resource "helm_release" "retail_store" {
  name       = "retail-store"
  repository = "https://aws-samples.github.io/eks-retail-store-sample-app"
  chart      = "eks-retail-store"
  namespace  = kubernetes_namespace_v1.retail_app.metadata[0].name

  timeout = 1200

  values = [
    yamlencode({
      ui = {
        service = {
          type = "LoadBalancer"
        }
      }
    })
  ]

  depends_on = [
    kubernetes_namespace_v1.retail_app,
    module.retail_app_eks
  ]
}

