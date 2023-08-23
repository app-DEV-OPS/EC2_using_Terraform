#creating subnet

resource "aws_subnet" "hga-subnet-tf-test" {
  vpc_id            = aws_vpc.hga-vpc-tf-test.id
  cidr_block        = "10.0.0.0/25"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "hga-subnet-tf-test"
  }
}
