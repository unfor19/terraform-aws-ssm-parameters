# terraform-aws-ssm-parameters

[![tests](https://github.com/unfor19/terraform-aws-ssm-parameters/actions/workflows/tests.yml/badge.svg)](https://github.com/unfor19/terraform-aws-ssm-parameters/actions/workflows/tests.yml) [![Terraform-Registry](https://img.shields.io/github/v/release/unfor19/terraform-aws-ssm-parameters?color=purple&label=terraform-registry&logo=terraform)](https://registry.terraform.io/modules/unfor19/ssm-parameters/aws/latest)

Create AWS SSM Parameter Store parameters with a Terraform module. The creation/deletion (schema) is managed with Terraform, and the values should be maintained via AWS Console.

## Usage

```ruby
module "app_params" {
    source  = "unfor19/ssm-parameters/aws"
    version = "0.0.2"

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
| stringlist_parameters | List of StringList(s) | `list(string)` | `[]` | no |
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
## Troubleshooting

- **ParameterAlreadyExists** - to overcome this error, you'll have to pass the `overwrite = true` variable. This also means that the current values will be overwritten with the dummy initial value `empty`. This is very dangerous and should be used with cautious.

  ```
  Error: error updating SSM parameter (/myapp/dev/GOOGLE_CLIENT_ID): ParameterAlreadyExists: Parameter /myapp/dev/GOOGLE_CLIENT_ID already exists.
  ```


## Local Development

<details>

<summary>Expand/Collapse</summary>

For local development, we'll use the following services

- [localstack](https://github.com/localstack/localstack) - A fully functional local cloud (AWS) stack
- [unfor19/tfcoding](https://github.com/unfor19/tfcoding) - Triggers a whole terraform pipeline of `terraform init` and `terraform fmt` and `terraform apply` upon changing the file [examples/basic/tfcoding.tf](./examples/basic/tfcoding.tf)

### Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Development Process

Run `tfcoding` and `localstack` locally with `docker-compose`

```bash
make up-localstack-aws
```

Make changes in [examples/basic/tfcoding.tf](./examples/basic/tfcoding.tf) and save the file

Check the logs of the `tfcoding` Docker container

```bash
# ... omitted for brevity
tfcoding-aws    | Outputs:
tfcoding-aws    | 
tfcoding-aws    | securestring_arns = [
tfcoding-aws    |   "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/GOOGLE_CLIENT_ID",
tfcoding-aws    |   "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/GOOGLE_CLIENT_SECRET",
tfcoding-aws    | ]
tfcoding-aws    | securestring_names = [
tfcoding-aws    |   "/myapp/dev/GOOGLE_CLIENT_ID",
tfcoding-aws    |   "/myapp/dev/GOOGLE_CLIENT_SECRET",
tfcoding-aws    | ]
tfcoding-aws    | string_arns = [
tfcoding-aws    |   "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/LOG_LEVEL",
tfcoding-aws    | ]
tfcoding-aws    | string_names = [
tfcoding-aws    |   "/myapp/dev/LOG_LEVEL",
tfcoding-aws    | ]
tfcoding-aws    | stringlist_arns = []
tfcoding-aws    | stringlist_names = []
```

### Test Suite

Execute the script [scripts/tests.sh](./scripts/tests.sh)

```bash
make test
```

Examine the output

```bash
... # omitted for brevity
Outputs:

securestring_arns = [
  "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/GOOGLE_CLIENT_ID",
  "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/GOOGLE_CLIENT_SECRET",
]
securestring_names = [
  "/myapp/dev/GOOGLE_CLIENT_ID",
  "/myapp/dev/GOOGLE_CLIENT_SECRET",
]
string_arns = [
  "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/LOG_LEVEL",
]
string_names = [
  "/myapp/dev/LOG_LEVEL",
]
stringlist_arns = []
stringlist_names = []

\e[92m[SUCCESS]\e[0m Test passed as expected
```

**NOTE**: `\e[92m]...\e[0m]` is colorizing the text in CI/CD services logs such as [GitHub Actions](https://github.com/features/actions)

</details>

## Contributing

Report issues/questions/feature requests on the [Issues](https://github.com/unfor19/terraform-aws-ssm-parameters/issues) section.

Pull requests are welcome! These are the steps:

1. Fork this repo
1. Create your feature branch from master (`git checkout -b my-new-feature`)
1. Add the code of your new feature; expand the above *Local Development* section to learn how
1. Run tests on your code, feel free to add more tests
   ```bash
   make test
   ... # All good? Move on to the next step
   ```
1. Commit your remarkable changes (`git commit -am 'Added new feature'`)
1. Push to the branch (`git push --set-up-stream origin my-new-feature`)
1. Create a new Pull Request and provide details about your changes

## Authors

Created and maintained by [Meir Gabay](https://github.com/unfor19)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/unfor19/terraform-aws-ssm-parameters/blob/master/LICENSE) file for details
