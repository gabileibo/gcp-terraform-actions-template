terraform {
  backend "gcs" {
    bucket = "hello-from-gcp-v2-tf-state"
    prefix = "pipeline-admin"
  }
}


provider "github" {
}

provider "google" {
  project = var.project_id
  region  = var.region
}
