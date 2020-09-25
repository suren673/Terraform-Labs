# GCP authentication file
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
  //default = "tf-key.json"
}
# define GCP region
variable "gcp_region" {
  type        = string
  description = "GCP region"
  //default = "us-central1"
}
# define GCP project name
variable "gcp_project" {
  type        = string
  description = "GCP project name"
  //default =  "poc-project-286601"
}

variable "bucket_name" {
  type    = string
  default = "the name of the cloud storage bucket"
}

variable "storage_class" {
  type    = string
  default = "the name of the storage class"
}
