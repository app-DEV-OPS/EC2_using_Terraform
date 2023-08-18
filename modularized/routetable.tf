# creating route table
resource "aws_route_table" "hga-rt-tf-test" {
  vpc_id = aws_vpc.hga-vpc-tf-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG_way.id
  }

  tags = {
    Name = "route"
  }
}