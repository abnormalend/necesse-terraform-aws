resource "aws_s3_bucket" "backup_bucket" {
  bucket_prefix = "${var.game_name}-backup"
}

