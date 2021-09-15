
module "app_params" {
  source = "../../../src" # For local development
  # source  = "unfor19/ssm-parameters/aws"
  # version = "0.0.2"

  prefix = "/myapp/dev/"
  overwrite = true # Use with caution
  key_id = "alias/aws/ssm"

  string_tier = "Standard"
  securestring_tier = "Standard"
  stringlist_tier = "Standard"

  string_parameters = [
    "LOG_LEVEL",
  ]
  securestring_parameters = [
    "GOOGLE_CLIENT_ID",
    "GOOGLE_CLIENT_SECRET"
  ]
  stringlist_parameters = [
    "EXCLUDE_DIR_LIST",
    "INCLUDE_CONFIG_FILES"
  ]

  string_initial_value = "willy"
  securestring_initial_value = "wonka"
  stringlist_initial_value = "oompaloompa"
}


locals {
  string_arns = module.app_params.string_arns
  string_names = module.app_params.string_names
  securestring_arns = module.app_params.securestring_arns
  securestring_names = module.app_params.securestring_names
  stringlist_arns = module.app_params.stringlist_arns
  stringlist_names = module.app_params.stringlist_names  
}
