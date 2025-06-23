resource "terraform_data" "karpenter_resources" {

  provisioner "local-exec" {
    command = "${path.module}/cli/karpenter-resources-create.sh"
    when    = create
    environment = {
      REGION              = var.region
      CLUSTER_NAME        = local.eks_cluster_name
      KARPENTER_NODE_ROLE = local.karpenter_node_role_name
    }
  }

  depends_on = [helm_release.karpenter]
}
