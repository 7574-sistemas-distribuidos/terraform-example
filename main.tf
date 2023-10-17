terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.34.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = "us-central1"
  credentials = file(var.credentials_path)
}

data "google_client_openid_userinfo" "provider_identity" {
}

module "storage" {
  source = "./modules/storage"
  bucket_name = var.bucket_name
}

module "networking" {
  source = "./modules/networking"
}

module "web_servers" {
  source = "./modules/web_servers"
  subnet_id = module.networking.servers_subnet_id
  build_src_bucket = module.storage.bucket_name
  src_path = "src/web_server-python"
  compute_service_account = data.google_client_openid_userinfo.provider_identity.email
}

module "boundaries" {
  source = "./modules/boundaries"
  build_src_bucket = module.storage.bucket_name
}

module "controllers" {
  source = "./modules/controllers"
  build_src_bucket = module.storage.bucket_name
  timer_service_account = data.google_client_openid_userinfo.provider_identity.email
}

