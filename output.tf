# -----------------------------------------------------------------------------
# Kubectl Configuration Command
# -----------------------------------------------------------------------------
output "configure_kubectl" {
  description = "Command to update kubeconfig for this cluster"
  value       = module.retail_app_eks.configure_kubectl
}

# -----------------------------------------------------------------------------
# Retail Store Application URL
# -----------------------------------------------------------------------------
output "retail_app_url" {
  description = "URL to access the retail store application"
  value = try(
    "http://${data.kubernetes_service.ui_service.status[0].load_balancer[0].ingress[0].hostname}",
    "Load balancer still provisioning"
  )
}


# -----------------------------------------------------------------------------
# Bedrock Dev IAM Credentials (MANDATORY FOR GRADING)
# -----------------------------------------------------------------------------
output "bedrock_dev_view_access_key" {
  description = "Access key for bedrock-dev-view IAM user"
  value       = aws_iam_access_key.bedrock_dev_view.id
  sensitive   = true
}

output "bedrock_dev_view_secret_key" {
  description = "Secret key for bedrock-dev-view IAM user"
  value       = aws_iam_access_key.bedrock_dev_view.secret
  sensitive   = true
}

