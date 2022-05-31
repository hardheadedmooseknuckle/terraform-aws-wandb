resource "random_pet" "file_storage" {
  length = 2
}

# Enables bucket logging
resource "aws_s3_bucket" "log_storage" {
  bucket = "${var.namespace}-log-storage-${random_pet.file_storage.id}"

  force_destroy = !var.deletion_protection
}

resource "aws_s3_bucket_acl" "log_storage_acl" {
  bucket = aws_s3_bucket.log_storage.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "file_storage" {
  bucket = var.file_storage

  target_bucket = aws_s3_bucket.log_storage.id
  target_prefix = "${var.namespace}-logs/"
}

# Enables intelligent tiering storage class
resource "aws_s3_bucket_intelligent_tiering_configuration" "configuration" {
  bucket = aws_s3_bucket.log_storage.bucket
  name   = "${var.namespace}-logs"

  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 125
  }
}