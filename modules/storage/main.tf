resource "google_storage_bucket" "default" {
  name                        = "123-experimental"
  location                    = "US"
  uniform_bucket_level_access = true
}

