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

  source_ranges = ["213.134.188.216/32"] # my ip :P
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow-hc" {
  name    = "allow-hc"
  network = google_compute_network.web-app-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["35.191.0.0/16"] # my ip :P
  target_tags   = ["http-server"]
}