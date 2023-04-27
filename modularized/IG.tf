# creating Internet Gateway
resource "aws_internet_gateway" "IG_way" {
  vpc_id = aws_vpc.myfirstvpc.id

  tags = {
    Name = "IG-1"
  }
}