#!/usr/bin/env bash

set -eo pipefail

GIT_BIN=$(which git)
SPATH=$($GIT_BIN rev-parse --show-toplevel)

echo $SPATH

if [ ! -f "${SPATH}/README.json" ]; then
    echo "README.json with variables does not exist."
    exit 6
fi

GOMPLATE_BIN=`which gomplate`

if [ -z "$GOMPLATE_BIN" ]; then
    echo "gomplate is necessary and not installed"
    exit 4
fi

CURL_BIN=`which curl`

if [ -z $CURL_BIN ]; then
    echo "curl is necessary and not installed"
    exit 2
fi

$CURL_BIN -Ls https://raw.githubusercontent.com/Infrastrukturait/READMEgen/main/README.md.template |\
$GOMPLATE_BIN -d config="${SPATH}/README.json" >\
 "${SPATH}/README.md"

