variable "project_id" {
  default = "inpost-demo-4124"
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
  default = "4124"
}