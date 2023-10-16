resource "random_id" "default" {
  byte_length = 8
}

module "controllers_source" {
  source = "../common/function_source"

  build_src_bucket = var.build_src_bucket
  src_path = "src/controllers-python"
}

module "controller1_function" {
  source = "../common/function"

  function_name = "controller1-${random_id.default.hex}"
  build_src_bucket = module.controllers_source.bucket
  build_src_object = module.controllers_source.object
  entry_point = "controller1"
}

module "controller2_function" {
  source = "../common/function"

  function_name = "controller2-${random_id.default.hex}"
  build_src_bucket = module.controllers_source.bucket
  build_src_object = module.controllers_source.object
  entry_point = "controller2"
}

resource "google_cloud_scheduler_job" "controller1_timer" {
  name        = "controller1-timer"
  description = "Schedule the HTTPS trigger for controller1"
  schedule    = var.timer_schedule
  project     = module.controller1_function.project
  region      = module.controller1_function.location

  http_target {
    uri         = module.controller1_function.uri
    http_method = "GET"
    oidc_token {
      audience              = "${module.controller1_function.uri}/"
      service_account_email = var.timer_service_account
    }
  }
}

