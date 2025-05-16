resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = { Name = "${var.vpc.name}-${var.vpc.internet_gateway_name}" }
}
