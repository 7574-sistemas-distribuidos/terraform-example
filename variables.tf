variable "credentials_path" {
  type = string
  description = "The path to the json file with the credentials of the service account with right to manage the infrastructure."
}
variable "project_id" {
  type = string
  description = "The GCP project_id to deploy the infrastructure on it."
}
variable "bucket_name" {
  type = string
  description = "The name of the bucket to store source codes, images, output results along the examples. If already exist, you need to execute the command `terraform import module.storage.google_storage_bucket.default <BUCKET-NAME>` to skip it during creation phase."
}
