resource "aws_db_instance" "db" {
  db_name              = "${var.stage}${var.app_name}"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16.1"
  instance_class       = "db.t4g.small"
  username             = "${var.app_name}"
  password             = random_password.password.result
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
  iam_database_authentication_enabled = false
}
