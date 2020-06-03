#!/usr/bin/env bash

# NOTE: Will only get the first 1000 results, because that's what GitHub lets us access

set -ex

override="$1"
data_dir="$2"

if [[ -z "$data_dir" ]]; then
    data_dir="code-data"
fi

mkdir -p "$data_dir"

github_token="$(cat "./github-token")"

if [[ -z "$github_token" ]]; then
    echo "No github token found in ./github-token"
    exit 1
fi

for i in $(seq 1 10); do
    fname="$data_dir/data-$i.json"
    if [[ "$override" == "--override" ]] || [[ ! -e "$fname" ]]; then
        curl -H "Authorization: token $github_token" "https://api.github.com/search/code?q=hyperledger+extension:yaml" > "$fname"
    fi
done

