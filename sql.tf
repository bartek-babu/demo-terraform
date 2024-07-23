resource "google_sql_database_instance" "web-app-sql" {
  name             = "web-app-sql"
  database_version = "POSTGRES_12"
  region           = var.region

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.web-app-vpc.self_link
    }

  }
}

resource "google_sql_database" "web-app-db" {
  name       = "web-app-db"
  instance   = google_sql_database_instance.web-app-sql.name
  depends_on = [google_sql_database_instance.web-app-sql]

}

resource "google_sql_user" "web-app-user" {
  name       = "web_app"
  instance   = google_sql_database_instance.web-app-sql.name
  password   = var.db_password
  depends_on = [google_sql_database_instance.web-app-sql]

}