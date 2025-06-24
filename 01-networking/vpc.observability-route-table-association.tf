resource "aws_route_table_association" "observability" {
  count = length(aws_subnet.observability)

  subnet_id      = aws_subnet.observability[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
