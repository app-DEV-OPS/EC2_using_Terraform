# create ubuntu server

resource "aws_instance" "webserver" {
   ami           = "yours"
   instance_type = "t2.micro"
   key_name          = "terraform"

   network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.NI-ip.id
  }

  tags = {
     Name = "webserver"
 }
}
