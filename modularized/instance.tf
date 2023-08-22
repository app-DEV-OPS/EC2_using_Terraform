# create ubuntu server

resource "aws_instance" "hga-ec2-tf-test" {
   ami           = "ami-08a52ddb321b32a8c"
   instance_type = "t2.medium"
   key_name          = "hga-adh-0823.pem"

   network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.hga-ni-tf-test.id
  }

  tags = {
     Name = "hga-ec2-tf-test"
 }
}
