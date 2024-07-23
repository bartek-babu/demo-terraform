resource "google_compute_network" "web-app-vpc" {
  name = "web-app"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "web-app-subnet"
  network       = google_compute_network.web-app-vpc.self_link
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
}

resource "google_compute_firewall" "allow-to-server" {
  name    = "allow-http"
  network = google_compute_network.web-app-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.allowed_ranges
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow-hc" {
  name    = "allow-hc"
  network = google_compute_network.web-app-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.google_hc_ip
  target_tags   = ["http-server"]
}