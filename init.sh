#!/bin/bash
set -eu -o pipefail
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export DEBIAN_FRONTEND=noninteractive

#install packets
apt-get update -y
for p in wget jq unzip curl moreutils realpath nc httpie fail2ban bind-utils; do
  for i in $(seq 0 10); do apt-get install -y "$p" && break; sleep 10s; apt-get update -y;  done
done

# update jq 2 latest version 1.6, we need theese features!
wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x jq-linux64
mv jq-linux64 $(which jq|echo '/usr/bin/jq')

# decode settings
ENV_64BASE=$1
ENV_DECODED=$(echo "$ENV_64BASE" | base64 --decode)

#download init & run 
##############################################################
src=$(mktemp -d -p "$DIR")

pushd "$src"

url=$(echo "$ENV_DECODED" | jq -e --raw-output '.initURL|select(type == "string")')
wget "$url" -O "$src/init.zip"
unzip -o "$src/init.zip"
find "." -type f  -name "*.sh" -exec chmod +x {} \;

./init.sh "$ENV_DECODED"

popd 
