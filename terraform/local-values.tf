# Define Local Values in Terraform
locals {
  owners      = var.owner
  environment = var.environment
  name        = "${var.business_divsion}-${var.environment}"
  common_tags = {
    owners               = local.owners
    environment          = local.environment
    "Project"            = "Kubernetes POC"
    "billing:costcenter" = "Internal RnD: Data Engineering Team"
  }
  eks_cluster_name = "${local.name}-${var.cluster_name}"
} 