#!/usr/bin/env bash

set -euo pipefail

readonly SCRIPT_NAME=$(basename $0)
readonly PWD=$(pwd)

log() {
  logger -s -t $SCRIPT_NAME -- $*
}

usage() {
  echo <<-EOF
    USAGE
EOF
}
