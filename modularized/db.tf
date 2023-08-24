resource "aws_db_instance" "hga_lamp-db" {
  count = 2
  allocated_storage    = 20
  storage_type        = "gp2"
  identifier          = "rdstf"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Adhi082023"
  publicly_accessible = true
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
   tags = {
     Name = "hgalampdb-${count.index}"
   }
 }
