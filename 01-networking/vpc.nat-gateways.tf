resource "aws_nat_gateway" "this" {
  count = length(aws_subnet.public)

  allocation_id = aws_eip.this[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = { Name = "${var.vpc.name}-${var.vpc.nat_gateway_name}-${aws_subnet.public[count.index].availability_zone}" }

  depends_on = [aws_internet_gateway.this]
}
