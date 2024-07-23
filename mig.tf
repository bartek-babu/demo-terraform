resource "google_compute_instance_template" "web-app-template" {
  name         = "web-app-template"
  machine_type = "e2-medium"

  tags = ["http-server"]

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-2004-lts"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = google_compute_network.web-app-vpc.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {}
  }

  metadata_startup_script = <<-EOF
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
}

resource "google_compute_region_instance_group_manager" "regional_instance_group_manager" {
  name                      = "web-app-mig"
  base_instance_name        = "web-app"
  region                    = var.region
  target_size               = 3
  distribution_policy_zones = var.zones

  version {
    instance_template = google_compute_instance_template.web-app-template.self_link
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.web-app.self_link
    initial_delay_sec = 300
  }

  named_port {
    name = "http"
    port = 80
  }

  depends_on = [google_compute_instance_template.web-app-template]
}
