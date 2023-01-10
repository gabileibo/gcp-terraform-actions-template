locals {
  workload_identity_provider = "${google_iam_workload_identity_pool.github_pool.name}/providers/${google_iam_workload_identity_pool_provider.github.workload_identity_pool_provider_id}"
}

# vulnerability_alerts is a bug, its enabled by default in public repos and if we set it github provider sometimes throws a 422 on apply
# tfsec:ignore:github-repositories-enable_vulnerability_alerts tfsec:ignore:github-repositories-private
resource "github_repository" "repo" {
  name       = var.repo_name
  visibility = "public"
}

resource "github_repository_environment" "terraform_apply_env" {
  environment = "terraform-apply"
  repository  = github_repository.repo.name
}
# Do not store actual secret data here, just dummy values or safe env variables
resource "github_actions_environment_secret" "workload_identity_provider" {
  repository      = github_repository_environment.terraform_apply_env.repository
  environment     = github_repository_environment.terraform_apply_env.environment
  secret_name     = "GCP_WORKLOAD_IDENTITY_PROVIDER"
  plaintext_value = local.workload_identity_provider
}
resource "github_actions_environment_secret" "sa_email" {
  repository      = github_repository_environment.terraform_apply_env.repository
  environment     = github_repository_environment.terraform_apply_env.environment
  secret_name     = "GCP_SERVICE_ACCOUNT_EMAIL"
  plaintext_value = google_service_account.terraform_readwrite.email
}

resource "github_repository_environment" "terraform_plan_env" {
  environment = "terraform-plan"
  repository  = github_repository.repo.name
}
# Do not store actual secret data here, just dummy values or safe env variables
resource "github_actions_environment_secret" "readonly_workload_identity_provider" {
  repository      = github_repository_environment.terraform_plan_env.repository
  environment     = github_repository_environment.terraform_plan_env.environment
  secret_name     = "GCP_WORKLOAD_IDENTITY_PROVIDER"
  plaintext_value = local.workload_identity_provider
}

resource "github_actions_environment_secret" "readonly_sa_email" {
  repository      = github_repository_environment.terraform_plan_env.repository
  environment     = github_repository_environment.terraform_plan_env.environment
  secret_name     = "GCP_SERVICE_ACCOUNT_EMAIL"
  plaintext_value = google_service_account.terraform_readonly.email
}
