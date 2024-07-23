output "vm_sa" {
  description = "Vms service account email."
  value       = module.service_accounts.email
}

output "bucket_id" {
  description = "unique bucket name"
  value       = google_storage_bucket.web-app-storage.name
}

output "conenction_string" {
  description = "connection string to sql"
  value       = google_sql_database_instance.web-app-sql.connection_name
}

output "load_balancer_ip" {
  description = "external load balancer ip"
  value       = google_compute_global_forwarding_rule.web-app.ip_address
}