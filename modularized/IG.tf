# creating Internet Gateway
resource "aws_internet_gateway" "hga-igw-tf-test" {
  vpc_id = aws_vpc.hga-vpc-tf-test.id

  tags = {
    Name = "hga-igw-tf-test"
  }
}