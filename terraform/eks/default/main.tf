# -----------------------------------------------------------------------------
# Locals
# -----------------------------------------------------------------------------
locals {
  security_groups_active = !var.opentelemetry_enabled
}

# -----------------------------------------------------------------------------
# Global Tags Module
# -----------------------------------------------------------------------------
module "tags" {
  source           = "../../lib/tags"
  environment_name = "project-bedrock"
}

# -----------------------------------------------------------------------------
# VPC Module
# -----------------------------------------------------------------------------
module "vpc" {
  source = "../../lib/vpc"

  environment_name = "project-bedrock"

  public_subnet_tags = {
    "kubernetes.io/cluster/project-bedrock-cluster" = "shared"
    "kubernetes.io/role/elb"                        = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/project-bedrock-cluster" = "shared"
    "kubernetes.io/role/internal-elb"               = 1
  }

  tags = module.tags.result
}

# -----------------------------------------------------------------------------
# EKS Cluster Module
# -----------------------------------------------------------------------------
module "retail_app_eks" {
  source = "../../lib/eks"

  providers = {
    kubernetes.cluster = kubernetes
    kubernetes.addons  = kubernetes
    helm               = helm
  }

  environment_name      = "project-bedrock"
  cluster_version       = "1.34"
  vpc_id                = module.vpc.inner.vpc_id
  vpc_cidr              = module.vpc.inner.vpc_cidr_block
  subnet_ids            = module.vpc.inner.private_subnets
  opentelemetry_enabled = var.opentelemetry_enabled
  tags                  = module.tags.result
  istio_enabled         = var.istio_enabled
}

# -----------------------------------------------------------------------------
# Dependency Services Module (DB, Redis, MQ, etc)
# -----------------------------------------------------------------------------
module "dependencies" {
  source = "../../lib/dependencies"

  environment_name = "project-bedrock"
  tags             = module.tags.result

  vpc_id     = module.vpc.inner.vpc_id
  subnet_ids = module.vpc.inner.private_subnets

  catalog_security_group_id  = local.security_groups_active ? aws_security_group.catalog.id : module.retail_app_eks.node_security_group_id
  orders_security_group_id   = local.security_groups_active ? aws_security_group.orders.id : module.retail_app_eks.node_security_group_id
  checkout_security_group_id = local.security_groups_active ? aws_security_group.checkout.id : module.retail_app_eks.node_security_group_id
}

# -----------------------------------------------------------------------------
# Helm Release for UI
# -----------------------------------------------------------------------------
resource "helm_release" "ui" {
  name       = "ui"
  chart      = "../../../src/ui/chart"
  namespace  = "ui"

  create_namespace = true
  }
}

# -----------------------------------------------------------------------------
# Note: Data sources and providers must be in separate files (provider.tf / data.tf)
# -----------------------------------------------------------------------------
# In pr

