#!/usr/bin/env bash

# This script will generate traffic against a provided AWS ELB
# For test purposed, the number of requests is hardcoded to 1000000 and concurency level set to 5000 

set -eu

REQUESTS=1000000
CONCURENCY=1000

eerror() {
    echo "[ERROR] >>> $*" >&2
}

einfo() {
    echo "[INFO] >>> $*"
}

eusage() {
  eerror "Please provide a valid ELB DNS endpoint in format http[s]://<ENDPOINT>/" && exit 1 
}
[ ! $(command -v ab) ] && eerror "Apache Bench tool (ab) seems not to be installed. Please refer to the README.md."
[ $# -ne 1 ] || [[ ! "$1" =~ ^http[s]?://.*/ ]] && eusage

LOAD_BALANCER="$1"

ab -k -n $REQUESTS -c $CONCURENCY "$LOAD_BALANCER"