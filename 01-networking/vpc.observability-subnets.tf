resource "aws_subnet" "observability" {
  count = length(var.vpc.observability_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.vpc.observability_subnets[count.index].cidr_block
  availability_zone       = var.vpc.observability_subnets[count.index].availability_zone
  map_public_ip_on_launch = var.vpc.observability_subnets[count.index].map_public_ip_on_launch

  tags = {
    Name    = "${var.vpc.name}-${var.vpc.observability_subnets[count.index].name}",
    Purpose = "observability"
  }
}
