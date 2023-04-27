#creating security group

resource "aws_security_group" "SG1" {
  name_prefix = "allow-web"
  description = "allow web traffic"
  vpc_id      = aws_vpc.myfirstvpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" //-1 means every protocol allowed
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow web"
  }
}