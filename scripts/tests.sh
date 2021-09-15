#!/bin/bash
set -e
set -o pipefail

_DOCKERHUB_TAG="${DOCKERHUB_TAG:-"unfor19/tfcoding:0.14.8-latest"}"


error_msg(){
    local msg=$1
    echo -e "\e[31m[ERROR]\e[0m $msg"
    export DEBUG=1
    exit 1
}

should(){
    local expected=$1
    local test_name=$2
    local expr=$3
    echo "-------------------------------------------------------"
    echo "[LOG] $test_name - Should $expected"
    echo "[LOG] Executing: $expr"
    output_msg=$(trap '$expr' EXIT)
    output_code=$?

    echo -e "[LOG] Output:\n\n$output_msg\n"

    if [[ $expected == "pass" && $output_code -eq 0 && ! $output_msg =~ .*(ERROR|Error|error).* ]]; then
        echo -e "\e[92m[SUCCESS]\e[0m Test passed as expected"
    elif [[ $expected == "fail" && $output_code -eq 1 ]] || [[ $expected == "fail" && $output_msg =~ .*(ERROR|Error|error).* ]]; then
        echo -e "\e[92m[SUCCESS]\e[0m Test failed as expected"
    else
        error_msg "Test output is not expected, terminating"
    fi
}


tfcoding(){
    docker run -t --rm --network "tfcoding_aws_shared" -v "${PWD}"/:/src/:ro \
        "${_DOCKERHUB_TAG}" "$@"
}


# Tests
make up-localstack
source scripts/wait_for_endpoints.sh "http://localhost:4566/health"
should pass "Examples - Basic" "tfcoding -r examples/basic --mock_aws"
