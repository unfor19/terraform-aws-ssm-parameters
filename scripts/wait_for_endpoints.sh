#!/usr/bin/env bash

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
ctrl_c() {
    exit 0
}


# Helper Functions
error_msg(){
  local msg="$1"
  echo -e "[ERROR] $(date) :: $msg"
  exit 1
}


log_msg(){
  local msg="$1"
  echo -e "[LOG] $(date) :: $msg"
}

_INTERVAL="${INTERVAL:-"3"}"
_MAX_ATTEMPTS="${MAX_ATTEMPTS:-"100"}"

wait_for_endpoints(){
    declare endpoints=($@)
    for endpoint in "${endpoints[@]}"; do
        counter=1
        while [[ $(curl -s -o /dev/null -w ''%{http_code}'' "$endpoint") != "200" ]]; do 
            counter=$((counter+1))
            log_msg "WAIT FOR ENDPOINTS :: Waiting for - ${endpoint}"
            if [[ $counter -gt "$_MAX_ATTEMPTS" ]]; then
                error_msg "WAIT FOR ENDPOINTS :: Not healthy - ${endpoint}"
            fi
            sleep "$_INTERVAL"
        done
        log_msg "WAIT FOR ENDPOINTS :: Healthy endpoint - ${endpoint}"
    done
}

wait_for_endpoints "$@"
