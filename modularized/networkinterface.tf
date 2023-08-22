#create a network interface with an ip in the subnet that was created 
resource "aws_network_interface" "hga-ni-tf-test" {
  subnet_id       = aws_subnet.hga-subnet-tf-test.id
  private_ip      = "10.0.1.50"
  security_groups = [aws_security_group.hga-sg1-tf-test.id]

  tags = {
    Name = "hga-ni-tf-test"
  }
}