# creating route table
resource "aws_route_table" "hga-rt-tf-test" {
  vpc_id = aws_vpc.hga-vpc-tf-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hga-igw-tf-test.id
  }

  tags = {
    Name = "hga-rt-tf-test"
  }
}