resource "aws_instance" "hga-ec2-tf-test" {
   count = 2
   ami           = "ami-091a58610910a87a9"
   instance_type = "t2.medium"
   key_name          = "hga-lamp-keypair"

   associate_public_ip_address = true
   vpc_security_group_ids = [
   "${aws_security_group.hga-sg1-tf-test.id}" ]
   subnet_id = "${aws_subnet.hga-subnet-tf-test.id}"

  user_data = file("./script.sh")
  
 
   tags = {
     Name = "hga-ec2-tf-test-${count.index}"
}
}
