terraform {
  backend "gcs" {
    bucket = "hello-from-gcp-tf-state"
    prefix = "pipeline-local-setup"
  }
}


provider "github" {
}

provider "google" {
  project = var.project_id
  region  = var.region
}
