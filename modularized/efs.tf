resource "aws_efs_file_system" "hga-lamp-efs" {
  creation_token = "hga-lamp-efs"
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  encrypted = "true"
  tags = {


  Name = "hga-lamp-efs"

}
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"

}
 }
 

resource "aws_efs_mount_target" "hga-lmp-efs-mnt" {
  file_system_id = aws_efs_file_system.hga-lamp-efs.id

  subnet_id      = aws_subnet.hga-subnet-tf-test.id
 security_groups = [ "aws_security_group.hga-tf-test-sg.id",
]

 depends_on = [
 aws_efs_file_system.hga-lamp-efs,
]
}



