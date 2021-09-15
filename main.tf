
# for_each  - https://www.terraform.io/docs/language/meta-arguments/for_each.html
# lifecycle - https://www.terraform.io/docs/language/meta-arguments/lifecycle.html

resource "aws_ssm_parameter" "string_parameters" {
  for_each  = toset(local.string_parameters)
  name      = "${local.prefix}${each.value}"
  type      = "String"
  value     = local.string_initial_value
  tier      = local.string_tier
  overwrite = local.overwrite
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


resource "aws_ssm_parameter" "securestring_parameters" {
  for_each  = toset(local.securestring_parameters)
  name      = "${local.prefix}${each.value}"
  type      = "SecureString"
  value     = local.securestring_initial_value
  tier      = local.securestring_tier
  key_id    = local.key_id
  overwrite = local.overwrite
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


resource "aws_ssm_parameter" "stringlist_parameters" {
  for_each  = toset(local.stringlist_parameters)
  name      = "${local.prefix}${each.value}"
  type      = "StringList"
  value     = local.stringlist_initial_value
  tier      = local.stringlist_tier
  overwrite = local.overwrite
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
