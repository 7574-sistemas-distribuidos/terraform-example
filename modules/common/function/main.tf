resource "google_cloudfunctions2_function" "default" {
  name        = var.function_name
  location    = var.function_location
  description = "Function: ${var.function_name} | Entry-Point: ${var.entry_point}"

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = var.build_src_bucket
        object = var.build_src_object
      }
    }
  }

  service_config {
    max_instance_count = var.max_instance_count
    available_memory   = var.available_memory
    timeout_seconds    = var.timeout_seconds
    ingress_settings   = var.ingress_settings
  }
}

module "iam_public_access"{
  source = "../iam_public_access"
  function_project = google_cloudfunctions2_function.default.project
  function_location = google_cloudfunctions2_function.default.location
  function_name = google_cloudfunctions2_function.default.name
}

