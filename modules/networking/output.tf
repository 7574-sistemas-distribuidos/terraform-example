output "servers_subnet_id" {
  value = google_compute_subnetwork.servers.id 
}
output "databases_subnet_id" {
  value = google_compute_subnetwork.databases.id 
}
