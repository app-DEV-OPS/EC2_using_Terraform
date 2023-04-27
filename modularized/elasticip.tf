# assign an elastic ip to network interface created 

resource "aws_eip" "eip1" {
  vpc               = true
  network_interface = aws_network_interface.NI-ip.id
  depends_on        = [aws_internet_gateway.IG_way]


  tags = {
    Name = "eip"
  }
}
resource "aws_eip_association" "eip_assoc" {
  network_interface_id = aws_network_interface.NI-ip.id
  allocation_id        = aws_eip.eip1.id

  depends_on = [aws_internet_gateway.IG_way]
}