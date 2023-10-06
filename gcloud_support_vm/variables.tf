variable "resources_prefix" {
  type    = string
  default = "dmurga-support"
}

variable "project_id" {
  default     = "rancher-support-01"
  description = "rancher-support Project"
}

variable "region" {
  default     = "europe-west8"
  description = "europe-west8 (Milan)"
}

variable "ssh_key" {
  type    = string
  default = ".ssh/google_compute_engine"
}

variable "support_bundle_repo" {
  type    = string
  default = "https://github.com/rancher/support-bundle-kit.git"
}

variable "ssh_user" {
  type    = string
  default = "dmurga"
}