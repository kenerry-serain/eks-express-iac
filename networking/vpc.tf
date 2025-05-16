resource "aws_vpc" "this" {
  cidr_block = var.vpc.cidr_block
  
  tags       = { Name = var.vpc.name }
}
