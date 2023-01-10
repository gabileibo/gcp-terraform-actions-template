terraform {
  backend "gcs" {
    bucket = "hello-from-gcp-tf-state"
    prefix = "hello-from-gcp"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
