resource "google_compute_network" "vpc_network" {
  name = "shared-vpc"
  auto_create_subnetworks = false
  mtu = 1460
}

resource "google_compute_subnetwork" "servers" {
  name          = "servers-subnet"
  ip_cidr_range = "10.0.1.0/24"
#  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "databases" {
  name          = "databases-subnet"
  ip_cidr_range = "10.0.2.0/24"
#  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "flask_5000" {
  name    = "flask-app-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["5000"]
  }
  source_ranges = ["0.0.0.0/0"]
}
