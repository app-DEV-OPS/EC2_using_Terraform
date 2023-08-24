resource "aws_instance" "hga-ec2-tf-test" {
   count = 2
   ami           = "ami-091a58610910a87a9"
   instance_type = "t2.medium"
   key_name          = "hga-lamp-keypair"

   associate_public_ip_address = true
   vpc_security_group_ids = [
   "${aws_security_group.hga-sg1-tf-test.id}" ]
   subnet_id = "${aws_subnet.hga-subnet-tf-test.id}"
   
   connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("hga-lamp-keypair.pem")
    host = aws_instance.hga-ec2-tf-test.pubic_ip
}

provisioner "remote-exec" {

inline = [
  "sudo yum install amazon-ef-utils httpd php git -y",
  "sudo systemctl restart httpd",
  "sudo systemctl enable httpd",
  "sudo setenforce 0",
  "sudo yum install nfs-utils -y",
  "sudo mount -f efs ${aws_efs_file_system.hga-lampefs.id}:/ /var/www/html",
  "sudo echo efs ${aws_efs_file_system.hga-lampefs.id}:/ /var/www/html efs default_netdev 0 0 >> sudo /etc/fstab",
  " sudo rm -f /var/www/html/",
  "sudo git clone https://github.com/ther1chie/efs-task.git /var/www/html",
]

}
   tags = {
     Name = "hga-ec2-tf-test-${count.index}"
}
}
