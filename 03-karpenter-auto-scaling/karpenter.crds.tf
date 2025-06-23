resource "terraform_data" "karpenter_crds" {

  provisioner "local-exec" {
    command = "${path.module}/cli/karpenter-crds-create.sh"
    when    = create
    environment = {
      REGION       = var.region
      CLUSTER_NAME = local.eks_cluster_name
    }
  }
}
