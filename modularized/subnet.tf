#creating subnet

resource "aws_subnet" "hga-subnet-tf-test" {
  vpc_id            = aws_vpc.hga-vpc-tf-test.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "hga-subnet-tf-test"
  }
}