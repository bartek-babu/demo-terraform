resource "google_compute_health_check" "web-app" {
  name = "http-basic-check"

  http_health_check {
    request_path = "/"
    port         = 80
  }
}

resource "google_compute_backend_service" "web-app" {
  name                            = "web-backend-service"
  health_checks                   = [google_compute_health_check.web-app.self_link]
  load_balancing_scheme           = "EXTERNAL"
  port_name                             = "http"
  protocol                        = "HTTP"
  timeout_sec                     = 10
  connection_draining_timeout_sec = 300

  backend {
    group = google_compute_region_instance_group_manager.regional_instance_group_manager.instance_group
  }

  depends_on = [google_compute_health_check.web-app, google_compute_region_instance_group_manager.regional_instance_group_manager]
}

resource "google_compute_url_map" "web-app" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.web-app.self_link
  depends_on      = [google_compute_backend_service.web-app]
}

resource "google_compute_target_http_proxy" "web-app" {
  name       = "http-lb-proxy"
  url_map    = google_compute_url_map.web-app.self_link
  depends_on = [google_compute_url_map.web-app]
}

resource "google_compute_global_address" "web-app-lb-ip" {
  provider     = google
  name         = "web-app-lb-ip"
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "web-app" {
  name                  = "http-content-rule"
  target                = google_compute_target_http_proxy.web-app.self_link
  port_range            = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.web-app-lb-ip.address
  depends_on            = [google_compute_global_address.web-app-lb-ip, google_compute_target_http_proxy.web-app]
}
