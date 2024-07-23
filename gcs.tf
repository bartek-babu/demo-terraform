resource "google_storage_bucket" "web-app-storage" {
  name     = "${var.env}-web-app-storage-${var.id_suffix}"
  location = "EU"
  #force_destroy = true

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "web-app-member" {
  bucket     = google_storage_bucket.web-app-storage.name
  role       = "roles/storage.objectUser"
  member     = "serviceAccount:${module.service_accounts.email}"
  depends_on = [google_storage_bucket.web-app-storage, module.service_accounts]
}
