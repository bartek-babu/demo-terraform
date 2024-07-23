module "service_accounts" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 4.0"
  project_id = var.project_id
  prefix     = var.env
  names      = ["web-app"]
  project_roles = [
    "${var.project_id}=>roles/cloudsql.client"
  ]
}
