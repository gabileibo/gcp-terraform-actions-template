variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP default region"
}

variable "tf_state_bucket" {
  type        = string
  description = "Bucket name storing state"
}
