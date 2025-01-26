terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.17.0"
    }
  }
}

provider "google" {
  project = "terrform-gcp-demo-449011"
  region  = "europe-west3"
}
resource "google_storage_bucket" "deom-bucket" {
  name          = "terrform-gcp-demo-449011-terra-bucket"
  location      = "europe-west3"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}