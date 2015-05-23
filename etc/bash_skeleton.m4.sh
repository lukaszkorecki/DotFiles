#!/usr/bin/env bash

set -euo pipefail

readonly SCRIPT_NAME=$(basename $0)

log() {
  logger -s -t $SCRIPT_NAME -- $*
}
