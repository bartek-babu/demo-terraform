terraform {
  backend "gcs" {
    bucket  = "dev-tf-state-5675"
    prefix  = "terraform/state"
  }
}