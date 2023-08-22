# assign an elastic ip to network interface created 

resource "aws_eip" "hga-eip-tf-test" {
  vpc               = true
  network_interface = aws_network_interface.hga-ni-tf-test.id
  depends_on        = [aws_internet_gateway.hga-igw-tf-test]


  tags = {
    Name = "hga-eip-tf-test"
  }
}
resource "aws_eip_association" "hga-eip_assoc-tf-test" {
  network_interface_id = aws_network_interface.hga-ni-tf-test.id
  allocation_id        = aws_eip.hga-eip-tf-test.id

  depends_on = [aws_internet_gateway.hga-igw-tf-test]
}