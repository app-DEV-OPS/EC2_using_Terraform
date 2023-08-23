#creating vpc

resource "aws_vpc" "hga-vpc-tf-test" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "hga-vpc-tf-test"
  }
}
