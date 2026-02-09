resource "aws_eks_addon" "cloudwatch" {
  cluster_name = module.retail_app_eks.cluster_name
  addon_name   = "amazon-cloudwatch-observability"
}

