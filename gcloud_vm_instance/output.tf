output "ip" {
  value = google_compute_instance.ubuntu-pro-focal-1.network_interface[0].access_config[0].nat_ip
}


output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}