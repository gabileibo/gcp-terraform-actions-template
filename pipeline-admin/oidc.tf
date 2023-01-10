# Decalre Github Pool
resource "google_iam_workload_identity_pool" "github_pool" {
  project                   = var.project_id
  workload_identity_pool_id = "github-pool"
  display_name              = "GitHub pool"
  description               = "Identity pool for GitHub deployments"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.full"       = "assertion.repository+assertion.ref"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# read+write SA
resource "google_service_account" "terraform_readwrite" {
  account_id = "terraform"
}

resource "google_project_iam_member" "terraform_readwrite" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.terraform_readwrite.email}"
}

# we add the default branch to the principleSet to limit the accounts usage to be main branch only
resource "google_service_account_iam_member" "workload_identity_user_readwrite" {
  service_account_id = google_service_account.terraform_readwrite.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.full/${github_repository.repo.full_name}refs/heads/main"
}

# readonly SA 
resource "google_service_account" "terraform_readonly" {
  account_id = "terraform-readonly"
}

resource "google_project_iam_member" "terraform_readonly" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.terraform_readonly.email}"
}

resource "google_service_account_iam_member" "workload_identity_user_readonly" {
  service_account_id = google_service_account.terraform_readonly.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${github_repository.repo.full_name}"
}

# make sure the read only key can set locks
data "google_storage_bucket" "tf_state_bucket" {
  name = var.tf_state_bucket
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = data.google_storage_bucket.tf_state_bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.terraform_readonly.email}"
}
