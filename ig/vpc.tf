# VPC
resource "google_compute_network" "default" {
  name                    = "ig-lb-network"
  auto_create_subnetworks = false
}

# backend subnet
resource "google_compute_subnetwork" "default" {
  name          = "ig-lb-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.default.id
}

# allow access from health check ranges
resource "google_compute_firewall" "default" {
  name          = "ig-lb-fw-allow-hc"
  direction     = "INGRESS"
  network       = google_compute_network.default.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["allow-health-check"]

  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
}

# allow access from health check ranges
resource "google_compute_firewall" "ssh" {
  name          = "ig-ssh"
  direction     = "INGRESS"
  network       = google_compute_network.default.id
  source_ranges = ["0.0.0.0/0"]
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
}
