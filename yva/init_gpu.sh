#!/usr/bin/env bash
set -eu -o pipefail
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export DEBIAN_FRONTEND=noninteractive

  distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
  && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
  && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

#install packets, make retrys on update it sometimes fails at azure
apt-get update -y || true 
for p in wget jq unzip curl nvidia-docker2; do
  for i in $(seq 0 10); do 
    apt-get install -y "$p" && break;
    sleep 10s
    apt-get update -y || true
  done
done

  

  touch /etc/docker/daemon.json
  echo '{ "default-runtime": "nvidia",
          "runtimes": {
            "nvidia": {
              "path": "nvidia-container-runtime",
              "runtimeArgs": []
            }
         }
        }' \
  | jq -er '.' > /etc/docker/daemon.json
  service docker restart

# decode settings
ENV_64BASE=$1
ENV_DECODED=$(echo "$ENV_64BASE" | base64 --decode)
echo "$ENV_DECODED" > $(mktemp -p "$DIR" -t "debug.kv.XXXXXX.json")

upurl=$(echo "$ENV_DECODED" | jq -cer '.kv.PLATFORM_UPDATE_URL')
zipurl=$(curl -sSf "$upurl" | jq -cre '.assets.setup.source.url')

echo "Yva install: use >>$upurl<< and >>$zipurl<<." 1>&2
dir=$(mktemp -d)
pushd "$dir"
curl -sSf "$zipurl" -o "$dir/setup.zip"
unzip setup.zip 
./azure.sh "$ENV_DECODED"
popd
