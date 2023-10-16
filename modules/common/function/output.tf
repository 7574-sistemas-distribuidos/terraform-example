output "uri" {
  value = google_cloudfunctions2_function.default.service_config[0].uri
}
output "project" {
  value = google_cloudfunctions2_function.default.project
}
output "location" {
  value = google_cloudfunctions2_function.default.location
}
