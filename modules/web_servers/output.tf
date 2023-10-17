output "flask_server_url" {
 value = join("",["http://",google_compute_instance.flask_server.network_interface.0.access_config.0.nat_ip,":5000"])
}
