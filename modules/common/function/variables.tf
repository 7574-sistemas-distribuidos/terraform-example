variable "function_name" {
  type = string
  description = "The function name" 
}
variable "entry_point" {
  type = string
  description = "The entry point to deployed."
}
variable "build_src_bucket" {
  type = string
  description = "Name of the bucket to be used for source code building and deployment."
}
variable "build_src_object" {
  type = string
  description = "Name of the bucket object to be used for the source code building and deployment."
}
variable "runtime" {
  type = string
  description = "The rountime for the function (ie. python311, nodejs20, go121)"
  default = "python311"
}
variable "function_location" {
  type = string
  description = "The function deployment's region" 
  default = "us-central1"
}
variable "max_instance_count" {
  type = number
  description = "The max quantity of instances allowed for the function"
  default = 1
}
variable "available_memory"{
  type = string
  description = "The memory available for the function"
  default = "256M"
}
variable "timeout_seconds" {
  type = number
  description = "The timeout in seconds for the function execution"
  default = 60
}
variable "ingress_settings" {
  type = string
  description = "The ingress settings for the function"
  default = "ALLOW_ALL"
}
