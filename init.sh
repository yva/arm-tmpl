#!/bin/bash
set -eu -o pipefail
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export DEBIAN_FRONTEND=noninteractive

#install packets
apt-get update -y
for p in wget jq unzip curl; do
  for i in $(seq 0 10); do apt-get install -y "$p" && break; sleep 10s; apt-get update -y;  done
done

# decode settings
ENV_64BASE=$1
ENV_DECODED=$(echo "$ENV_64BASE" | base64 --decode)

defUpdateURL='https://dl.yva.ai/public/releases/yva/release/yva.vm.json'
EXT_PLATFORM_INIT_KV_OVERLOAD="{  \"kv\": { \"PLATFORM_UPDATE_URL\": \"${1:-${PLATFORM_UPDATE_URL:-$defUpdateURL}}\" } }"
PLATFORM_INIT_KV_OVERLOAD=$( ( echo "$EXT_PLATFORM_INIT_KV_OVERLOAD"; echo "${PLATFORM_INIT_KV_OVERLOAD:-{\}}" | jq -cer '.') | jq -ser '.[0] * .[1]' )

upurl=$(echo "$ENV_DECODED" | jq -cer '.kv.PLATFORM_UPDATE_URL')
zipurl=$(curl -sSf "$upurl" | jq -cre '.assets.setup.source.url')

echo "Yva install: use >>$upurl<< and >>$zipurl<<." 1>&2

dir=$(mktemp -d -p "$DIR")
pushd "$dir"
curl -sSf "$zipurl" -o "$dir/setup.zip"
unzip setup.zip 
./azure.sh
popd
