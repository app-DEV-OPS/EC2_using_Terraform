#create a network interface with an ip in the subnet that was created 
resource "aws_network_interface" "hga-ni-ip" {
  subnet_id       = aws_subnet.subnet.id
  private_ip      = "10.0.1.50"
  security_groups = [aws_security_group.hga-sg1.id]

  tags = {
    Name = "network-interface"
  }
}