#!/usr/bin/env bash
set -e
set -o pipefail

### Requires Docker

# Generate .docs.md file
docker run -v "$PWD"/:/module/ quay.io/terraform-docs/terraform-docs:0.10.1 markdown table /module/ > .docs.md

# Inject docs to README.md
docker run --rm -v "$PWD"/:/app unfor19/replacer -sv "<\!-- terraform_docs_start -->" -ev "<\!-- terraform_docs_end -->"  -sf /app/.docs.md -df /app/README.md -cb false
