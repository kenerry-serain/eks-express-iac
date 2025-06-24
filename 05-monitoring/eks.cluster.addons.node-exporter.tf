resource "aws_eks_addon" "node_exporter" {
  cluster_name             = local.eks_cluster_name
  addon_name               = "prometheus-node-exporter"
}