resource "aws_ecr_repository" "watcher" {
  name = "${var.app_name}_${var.stage}"
}