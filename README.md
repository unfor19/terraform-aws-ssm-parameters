# terraform-aws-ssm-parameters

[![Tests](https://github.com/unfor19/terraform-aws-ssm-parameters/actions/workflows/tests.yml/badge.svg)](https://github.com/unfor19/terraform-aws-ssm-parameters/actions/workflows/tests.yml)

Create AWS SSM Parameter Store parameters with a Terraform module. The creation/deletion (schema) is managed with Terraform, and the values should be maintained via AWS Console.

This module is available at [Terraform Registry](https://registry.terraform.io/modules/unfor19/ssm-parameters/aws/latest)

## Usage

```ruby
module "app_params" {
    source  = "unfor19/ssm-parameters/aws"
    version = "0.0.1"

    prefix = "/myapp/dev/"

    string_parameters = [
        "LOG_LEVEL",
    ]
    securestring_parameters = [
        "GOOGLE_CLIENT_ID",
        "GOOGLE_CLIENT_SECRET"
    ]
}
```

<!-- terraform_docs_start -->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.31 |
| aws | >= 3.38 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.38 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key_id | When using SecureString, use a specific KMS key | `string` | `"alias/aws/ssm"` | no |
| overwrite | **DANGEROUS** Overwrites parameter if exists, use carefully | `bool` | `false` | no |
| prefix | Set a prefix to all variables, for example: `/myapp/dev/` | `string` | `""` | no |
| securestring_initial_value | Initial value for SecureString(s) | `string` | `"empty"` | no |
| securestring_parameters | List of SecureString(s) | `list(string)` | `[]` | no |
| securestring_tier | Valid values: `Standard`, `Advanced` and `Intelligent-Tiering` | `string` | `"Standard"` | no |
| string_initial_value | Initial value for String(s) | `string` | `"empty"` | no |
| string_parameters | List of String(s) | `list(string)` | `[]` | no |
| string_tier | Valid values: `Standard`, `Advanced` and `Intelligent-Tiering` | `string` | `"Standard"` | no |
| stringlist_initial_value | Initial value for StringList(s) | `string` | `"empty"` | no |
| stringlist_parameters | List of StringList(s) **comma-separated** | `list(string)` | `[]` | no |
| stringlist_tier | Valid values: `Standard`, `Advanced` and `Intelligent-Tiering` | `string` | `"Standard"` | no |

## Outputs

| Name | Description |
|------|-------------|
| securestring_arns | List of SecureString ARNs |
| securestring_names | List of SecureString names |
| string_arns | List of String ARNs |
| string_names | List of String names |
| stringlist_arns | List of StringList ARNs |
| stringlist_names | List of StringList names |

<!-- terraform_docs_end -->

## Local Development

Using the following services

- [localstack](https://github.com/localstack/localstack) - A fully functional local cloud (AWS) stack
- [unfor19/tfcoding](https://github.com/unfor19/tfcoding) - Triggers a whole terraform pipeline of `terraform init` and `terraform fmt` and `terraform apply` upon changing the file [examples/basic/tfcoding.tf](./examples/basic/tfcoding.tf)

### Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Development Process

1. Run `tfcoding` and `localstack` locally with `docker-compose`
    ```bash
    make up-localstack-aws
    ```
1. Make changes in [examples/basic/tfcoding.tf](./examples/basic/tfcoding.tf) and save the file
2. Check the logs of the `tfcoding` Docker container

### Test Suite

1. Execute the script [scripts/tests.sh](./scripts/tests.sh)
   ```bash
   ./scripts/tests.sh
1. Examine the output - `\e[92m]...\e[0m]` is colorizing the text in CI/CD services logs such as [GitHub Actions](https://github.com/features/actions)
   ```
   Outputs:

   num_of_securestring = 2
   num_of_string = 1
   \e[92m[SUCCESS]\e[0m Test passed as expected
   ```

## Authors

Created and maintained by [Meir Gabay](https://github.com/unfor19)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/unfor19/terraform-aws-ssm-parameters/blob/master/LICENSE) file for details
