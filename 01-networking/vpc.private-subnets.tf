resource "aws_subnet" "private" {
  count = length(var.vpc.private_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.vpc.private_subnets[count.index].cidr_block
  availability_zone       = var.vpc.private_subnets[count.index].availability_zone
  map_public_ip_on_launch = var.vpc.private_subnets[count.index].map_public_ip_on_launch

  tags = {
    Name                     = "${var.vpc.name}-${var.vpc.private_subnets[count.index].name}",
    Purpose                  = var.vpc.eks_cluster_name_tag,
    "karpenter.sh/discovery" = var.vpc.eks_cluster_name_tag,
  }
}
