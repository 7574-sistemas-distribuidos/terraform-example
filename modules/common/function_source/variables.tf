variable "build_src_bucket" {
  type = string
  description = "Name of the bucket to be use for source code building and deployment."
}
variable "src_path" {
  type = string
  description = "Path to the source code folder to be deployed."
}

