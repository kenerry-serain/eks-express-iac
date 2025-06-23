resource "helm_release" "karpenter" {
  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  chart               = "karpenter"
  version             = "1.5.0"
  namespace           = "kube-system"
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  values = [
    "${templatefile("${path.module}/helm/values.yml", {
      NODEGROUP = local.eks_cluster_node_group_name
    })}"
  ]

  set {
    name  = "settings.clusterName"
    value = local.eks_cluster_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.karpenter_controller.arn
  }

  set {
    name  = "controller.resources.requests.cpu"
    value = 1
  }

  set {
    name  = "controller.resources.limits.cpu"
    value = 1
  }

  set {
    name  = "controller.resources.requests.memory"
    value = "1Gi"
  }

  set {
    name  = "controller.resources.limits.cpu"
    value = "1Gi"
  }

  depends_on = [
    terraform_data.karpenter_crds,
    aws_iam_role_policy_attachment.karpenter_controller_custom_policy
  ]
}
