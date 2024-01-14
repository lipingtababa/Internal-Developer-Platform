resource "aws_db_instance" "db" {
  db_name              = "${var.app_name}-${var.stage}-db"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.4"
  instance_class       = "db.m3g.medium"
  username             = "${var.app_name}"
  password             = random_password.password.result
  parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true
  iam_database_authentication_enabled = false
}
