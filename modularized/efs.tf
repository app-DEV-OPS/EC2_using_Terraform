resource "aws_efs_file_system" "hga-lamp-efs" {
  creation_token = "hga-lamp-efs"
  performance_mode = "generalPurpose"
     thoughput_mode = "bursting"
  encripted = "true"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
	  tags = {
    Name = "hga-lamp-efs"
  }
  }
}
resource "aws_efs_mount_target" "hga-lmp-efs-mnt" {
  file_system_id = aws_efs_file_system.hga-lamp-efs.id
  vpc_id = "aws_vpc.hga-vpc-tf-test.id"
  subnet_id      = aws_subnet.hga-subnet-tf-test.id
 security_groups = "aws_security_group.hga-tf-test-sg.id"

 depends_on = [
 aws_efs_file_system.hga-lamp-efs,
]
}



