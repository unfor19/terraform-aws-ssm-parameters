
output "string_arns" {
  value       = [for value in aws_ssm_parameter.string_parameters: value.arn]
  description = "List of String ARNs"
}

output "string_names" {
  value       = [for value in aws_ssm_parameter.string_parameters: value.name]
  description = "List of String names"
}

output "securestring_arns" {
  value       = [for value in aws_ssm_parameter.securestring_parameters: value.arn]
  description = "List of SecureString ARNs"
}

output "securestring_names" {
  value       = [for value in aws_ssm_parameter.securestring_parameters: value.name]
  description = "List of SecureString names"
}

output "stringlist_arns" {
  value       = [for value in aws_ssm_parameter.stringlist_parameters: value.arn]
  description = "List of StringList ARNs"
}

output "stringlist_names" {
  value       = [for value in aws_ssm_parameter.stringlist_parameters: value.name]
  description = "List of StringList names"
}
