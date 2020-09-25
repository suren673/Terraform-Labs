resource "google_storage_bucket" "tf-bucket" {
  project = var.gcp_project
  location = var.gcp_region
  force_destroy = true
  name = var.bucket_name
  storage_class = var.storage_class


  versioning {
    enabled = true
  }
}
