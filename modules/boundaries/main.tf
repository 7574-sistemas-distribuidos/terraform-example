resource "random_id" "default" {
  byte_length = 8
}

module "boundaries_source" {
  source = "../common/function_source"

  build_src_bucket = var.build_src_bucket
  src_path = "src/boundaries-python"
}

module "boundary1_function" {
  source = "../common/function"

  function_name = "boundary1-${random_id.default.hex}"
  build_src_bucket = module.boundaries_source.bucket
  build_src_object = module.boundaries_source.object
  entry_point = "boundary1"
}

module "boundary2_function" {
  source = "../common/function"

  function_name = "boundary2-${random_id.default.hex}"
  build_src_bucket = module.boundaries_source.bucket
  build_src_object = module.boundaries_source.object
  entry_point = "boundary2"
}

