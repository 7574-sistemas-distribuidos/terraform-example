resource "random_id" "default" {
  byte_length = 8
}

data "archive_file" "src_zip" {
  type        = "zip"
  output_path = "/tmp/${random_id.default.hex}-src.zip"
  source_dir  = var.src_path
}

resource "google_storage_bucket_object" "src_object" {
  name   = "web_server_source/${basename(var.src_path)}.zip"
  bucket = var.build_src_bucket
  source = data.archive_file.src_zip.output_path
}

resource "google_compute_instance" "flask_server" {
  name         = "flask-server"
  machine_type = "f1-micro"
  zone         = "us-central1-f"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync unzip; pip install flask; sudo mkdir /app; sudo chmod +rw /app; gsutil cp gs://${google_storage_bucket_object.src_object.bucket}/${google_storage_bucket_object.src_object.name} /tmp/webserver.zip; unzip /tmp/webserver.zip -d /app; python3 /app/app.py &"

  network_interface {
    subnetwork = var.subnet_id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  service_account {
    email  = var.compute_service_account
    scopes = ["cloud-platform"]
  }
}

