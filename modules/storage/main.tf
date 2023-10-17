resource "google_storage_bucket" "default" {
  name                        = var.bucket_name
  location                    = "US"
  uniform_bucket_level_access = true
}

