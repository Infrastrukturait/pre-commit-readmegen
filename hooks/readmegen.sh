#!/usr/bin/env bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

set -eo pipefail

if [ ! -f ./README.json ]; then 
    echo "README.json with variables does not exist."
    exit 1
fi

GOMPLATE_BIN=`which gomplate`

if [ -z "$GOMPLATE_BIN" ]; then
    echo "gomplate is necessary and not installed"
    exit 1
fi

CURL_BIN=`which curl`

if [ -z $CURL_BIN ]; then
    echo "curl is necessary and not installed"
    exit 1
fi

$CURL_BIN -Ls https://raw.githubusercontent.com/Infrastrukturait/READMEgen/main/README.md.template | gomplate -d config=./README.json > ./README.md

