variable "resources_prefix" {
  type    = string
  default = "dmurga"
}

variable "project_id" {
  default     = "rancher-support-01"
  description = "rancher-support Project"
}

variable "region" {
  default     = "europe-southwest1"
  description = "europe-southwest1 (Madrid)"
}

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}
