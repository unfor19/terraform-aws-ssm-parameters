
module "app_params" {
  source = "../../../src" # For local development
  # source  = "unfor19/ssm-parameters/aws"
  # version = "0.0.1"

  string_parameters = [
    "LOG_LEVEL",
  ]
  securestring_parameters = [
    "GOOGLE_CLIENT_ID",
    "GOOGLE_CLIENT_SECRET"
  ]
}


locals {
  num_of_string       = module.app_params.num_of_string
  num_of_securestring = module.app_params.num_of_securestring
}
