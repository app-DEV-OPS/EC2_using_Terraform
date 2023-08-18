# assoicate route table with subnet

resource "aws_route_table_association" "hga-route_assoc-tf-test" {
  subnet_id      = aws_subnet.hga-subnet-tf-test.id
  route_table_id = aws_route_table.hga-rt-tf-test.id
}
