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
echo "$ENV_DECODED" > $(mktemp -p "$DIR" -t "debug.kv.XXXXXX.json")


upurl=$(echo "$ENV_DECODED" | jq -cer '.kv.PLATFORM_UPDATE_URL')
zipurl=$(curl -sSf "$upurl" | jq -cre '.assets.setup.source.url')

echo "Yva install: use >>$upurl<< and >>$zipurl<<." 1>&2

dir=$(mktemp -d -p "$DIR")
pushd "$dir"
curl -sSf "$zipurl" -o "$dir/setup.zip"
unzip setup.zip 
./azure.sh "$ENV_DECODED"
popd
