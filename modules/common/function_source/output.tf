output "bucket" {
  value = google_storage_bucket_object.src_object.bucket
}
output "object" {
  value = google_storage_bucket_object.src_object.name
}

