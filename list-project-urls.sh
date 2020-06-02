#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "Usage: $0 DATA_DIR"
    echo "DATA_DIR - The directory containing json files from GitHub's repository search API."
    exit 1
fi

set -e
date
git rev-parse HEAD

data_dir="$1"

find "$data_dir" -name "*.json" | sort -V | while read -r fname; do
    jq -r ".items[].html_url" "$fname"
done

