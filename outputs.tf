
output "num_of_string" {
    value = length(aws_ssm_parameter.string_parameters)
    description = "Number of String(s)"
}

output "num_of_securestring" {
    value = length(aws_ssm_parameter.securestring_parameters)
    description = "Number of SecureString(s)"
}

output "num_of_stringlist" {
    value = length(aws_ssm_parameter.stringlist_parameters)
    description = "Number of StringList(s)"
}