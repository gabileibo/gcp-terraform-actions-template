resource "google_project_service" "iam_googleapis" {
  service = "iam.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager_googleapis" {
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "gcp_iamcredentials_service" {
  project = var.project_id
  service = "iamcredentials.googleapis.com"
}
