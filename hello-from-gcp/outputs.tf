
output "bootstrap_text" {
  value       = data.google_storage_bucket_object_content.bootstrap_text.content
  description = "bootstrap text to show in Github actions to ensure proper setup"
}
