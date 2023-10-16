variable "build_src_bucket" {
  type = string
  description = "Name of the bucket to be use for source code building and deployment."
}
variable "timer_service_account" {
  type = string
  description = "Service account name used for timer which invokes the function."
}
variable "timer_schedule" {
  type = string
  description = "Timer cron schedule."
  default = "*/1 * * * *" # every 1 minute

}
