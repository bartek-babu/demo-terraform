variable "project_id" {
  default = "inpost-demo-5675"
  type    = string
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zones" {
  description = "zones where mig will deploy"
  type        = list(string)
  default     = ["europe-west1-b", "europe-west1-c", "europe-west1-d"]
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "env" {
  type    = string
  default = "dev"
}

variable "id_suffix" {
  type    = string
  default = "5675"
}

variable "allowed_ranges" {
  default = ["213.134.188.216/32"]
  type = list
}

variable "google_hc_ip" {
  default = ["35.191.0.0/16"]
  type = list
}