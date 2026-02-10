resource "aws_eks_addon" "cloudwatch" {
  cluster_name      = module.retail_app_eks.eks_cluster_id
  addon_name        = "amazon-cloudwatch-observability"
  resolve_conflicts = "OVERWRITE"
}

