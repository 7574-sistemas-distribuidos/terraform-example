variable "subnet_id" {
  type = string
  description = "The ID of the subnetwork within the VPC."
}
variable "build_src_bucket" {
  type = string
  description = "Name of the bucket to be use for source code."
}
variable "src_path" {
  type = string
  description = "Path to the source code folder to be deployed."
}
variable "compute_service_account" {
  type = string
  description = "Service account to host the compute instance sessions."
}
