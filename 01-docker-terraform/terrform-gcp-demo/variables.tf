variable "credentials" {
  description = "The path to the service account key file"
  type        = string
  default     = "./keys/my-creds.json"

}


variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "europe-west1"
}

variable "project_id" {
  description = "The project ID"
  type        = string
  default     = "terrform-gcp-demo-449011"

}
variable "bq_dataset_name" {
  description = "The name of the BigQuery dataset"
  type        = string
  default     = "demo_dataset"
}

variable "gsc_bucket_name" {
  description = "My storage bucket name"
  type        = string
  default     = "terraform-gcp-demo-449011-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket storage class"
  default     = "STANDARD"

}

variable "region" {
  description = "The region of the resources"
  type        = string
  default     = "europe-west1"

}

# This code is compatible with Terraform 4.25.0 and versions that are backward compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

# This code is compatible with Terraform 4.25.0 and versions that are backward compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

# resource "google_compute_instance" "de-zoocamp" {
#   boot_disk {
#     auto_delete = true
#     device_name = "de-zoocamp"

#     initialize_params {
#       image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20250111"
#       size  = 30
#       type  = "pd-balanced"
#     }

#     mode = "READ_WRITE"
#   }

#   can_ip_forward      = false
#   deletion_protection = false
#   enable_display      = false

#   labels = {
#     goog-ec-src = "vm_add-tf"
#   }

#   machine_type = "e2-medium"
#   name         = "de-zoocamp"

#   network_interface {
#     access_config {
#       network_tier = "PREMIUM"
#     }

#     queue_count = 0
#     stack_type  = "IPV4_ONLY"
#     subnetwork  = "projects/terrform-gcp-demo-449011/regions/europe-west1/subnetworks/default"
#   }

#   scheduling {
#     automatic_restart   = true
#     on_host_maintenance = "MIGRATE"
#     preemptible         = false
#     provisioning_model  = "STANDARD"
#   }

#   service_account {
#     email  = "728262976586-compute@developer.gserviceaccount.com"
#     scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
#   }

#   shielded_instance_config {
#     enable_integrity_monitoring = true
#     enable_secure_boot          = false
#     enable_vtpm                 = true
#   }

#   zone = "europe-west1-d"
# }
