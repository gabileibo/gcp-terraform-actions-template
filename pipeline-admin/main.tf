terraform {
  backend "gcs" {
    bucket = "{%GCS_STATE_BUCKET_NAME%}"
    prefix = "pipeline-admin"
  }
}


provider "github" {
}

provider "google" {
  project = var.project_id
  region  = var.region
}
