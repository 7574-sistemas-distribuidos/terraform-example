resource "random_id" "default" {
  byte_length = 8
}

data "archive_file" "src_zip" {
  type        = "zip"
  output_path = "/tmp/${random_id.default.hex}-src.zip"
  source_dir  = var.src_path
}

resource "google_storage_bucket_object" "src_object" {
  name   = "function_source/${basename(var.src_path)}.zip"
  bucket = var.build_src_bucket
  source = data.archive_file.src_zip.output_path
}

