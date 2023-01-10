data "google_storage_bucket_object_content" "bootstrap_text" {
  name   = "bootstrap.txt"
  bucket = var.tf_state_bucket
}
