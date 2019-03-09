#!/bin/bash
set -eu -o pipefail

[ -z "${DEBUG:-}" ] || set -x
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

GTBRANCH=$(git rev-parse --abbrev-ref HEAD)
GTVERSION=$(git rev-parse HEAD | cut -c 1-12 -)
BRANCH=${1:-"$GTBRANCH:$GTVERSION"}
BRANCH=${BRANCH,,}

echo "Out: branches/$BRANCH" 1>&2 
echo "$DIR/init.sh" "$DIR"/*.json | upload.list.sh "public/arm/debug/branches/$BRANCH"

echo "public/arm/debug/branches/$BRANCH/yva.json"