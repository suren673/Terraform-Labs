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

variable "gcp_zone" {
  type        = string
  description = "GCP zone"
  //default = "us-central1-c"
}
# define GCP project name
variable "gcp_project" {
  type        = string
  description = "GCP project name"
  //default =  "poc-project-286601"
}

variable "vpn_name" {
  type        = string
  description = "custom vpn name"
  //default  = "terraform-custom-network-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "machine_types" {
  type = map
  default = {
    dev  = "f1-micro"
    test = "n1-highcpu-32"
    prod = "n1-highcpu-32"
  }
}
