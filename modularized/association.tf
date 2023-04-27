# assoicate route table with subnet

resource "aws_route_table_association" "route_assoc" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.firstroute.id
}
