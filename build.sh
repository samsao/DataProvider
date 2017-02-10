#!/bin/bash

set -e
function trap_handler() {
    echo $MODE
    echo -e "\n\nIt's a trap!"
    echo "*You are terminated*"
    exit 255
}
trap trap_handler TERM EXIT

MODE="$1"

if type xcpretty-travis-formatter &> /dev/null; then
    FORMATTER="-f $(xcpretty-travis-formatter)"
  else
    FORMATTER="-s"
fi

if [ "$MODE" = "cocoapods-lint" ]; then
    echo "Verifying that podspec lints."

    set -o pipefail && pod env && pod lib lint
    trap - EXIT
    exit 0
fi

echo "Unrecognised mode '$MODE'."
