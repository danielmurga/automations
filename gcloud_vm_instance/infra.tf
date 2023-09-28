data "google_client_openid_userinfo" "me" {}

resource "google_compute_address" "static_ip" {
  name = "${var.resources_prefix}-vm"
}
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = ".ssh/google_compute_engine"
  file_permission = "0600"
}
resource "google_compute_network" "vpc_network" {
  name = "${var.resources_prefix}-network"
}

resource "google_compute_instance" "ubuntu-pro-focal-1" {
  boot_disk {
    auto_delete = true
    device_name = "${var.resources_prefix}-vm"

    initialize_params {
      image = "projects/ubuntu-os-pro-cloud/global/images/ubuntu-pro-2004-focal-v20230614"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-custom-2-1024"
  tags         = ["allow-ssh"]

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
  }

  name = "${var.resources_prefix}-vm"
  allow_stopping_for_update = true

  network_interface {
    network = "default"
    access_config {}
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = false
    enable_secure_boot          = false
    enable_vtpm                 = false
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker"
    ]
  }
  
  zone = "europe-southwest1-c"
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "${var.resources_prefix}-allow-ssh"
  network       = "default"
  target_tags   = ["allow-ssh"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

