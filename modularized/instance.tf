resource "aws_instance" "hga-ec2-tf-test" {
   count = 2
   ami           = "ami-091a58610910a87a9"
   instance_type = "t2.medium"
   key_name          = "hga-lamp-keypair"

   associate_public_ip_address = true
   vpc_security_group_ids = [
   "${aws_security_group.hga-sg1-tf-test.id}" ]
   subnet_id = "${aws_subnet.hga-subnet-tf-test.id}"
   tags = {
     Name = "hga-ec2-tf-test-${count.index}"
}
user_data = <<EOF
#!/bin/sh
sudo dnf update
sudo dnf install java -y
sudo wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.23/bin/apache-tomcat-10.0.23.tar.gz
sudo tar -xvf apache-tomcat-10*.tar.gz
sudo mv apache-tomcat-10.0.23 /usr/local/tomcat
sudo sh /usr/local/tomcat/bin/startup.sh
EOF 
}

