resource "google_storage_bucket_object" "bootstrap_txt" {
  name   = "bootstrap.txt"
  source = "../bootstrap.txt"
  bucket = var.tf_state_bucket
}
