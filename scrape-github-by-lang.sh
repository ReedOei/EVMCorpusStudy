#!/usr/bin/env bash

# NOTE: Will only get the first 1000 results, because that's what GitHub let's us access

set -ex

override="$1"
data_dir="$2"

if [[ -z "$data_dir" ]]; then
    data_dir="data"
fi

for i in $(seq 1 10); do
    fname="$data_dir/data-$i.json"
    if [[ "$override" == "--override" ]] || [[ ! -e "$fname" ]]; then
        curl "https://api.github.com/search/repositories?q=language:Solidity&sort=stars&order=desc&per_page=100&page=$i" > "$fname"
    fi
done

