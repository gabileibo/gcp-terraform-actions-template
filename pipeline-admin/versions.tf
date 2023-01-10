terraform {
  required_version = "~> 1.3.6"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.12.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "~> 4.46.0"
    }
  }
}
