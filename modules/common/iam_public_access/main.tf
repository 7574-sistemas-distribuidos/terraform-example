resource "google_cloudfunctions2_function_iam_member" "invoker" {
  project        = var.function_project
  cloud_function = var.function_name
  location       = var.function_location
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloud_run_service_iam_member" "invoker" {
  project  = var.function_project
  service  = var.function_name
  location = var.function_location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
