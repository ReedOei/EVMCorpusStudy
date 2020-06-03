#!/usr/bin/env bash

# NOTE: Will only get the first 1000 results, because that's what GitHub lets us access

set -ex

override="$1"
data_dir="$2"

if [[ -z "$data_dir" ]]; then
    data_dir="data"
fi

mkdir -p "$data_dir"

for i in $(seq 1 10); do
    fname="$data_dir/data-$i.json"
    if [[ "$override" == "--override" ]] || [[ ! -e "$fname" ]]; then
        # NOTE: This search only finds repositories "Written in" (i.e., primarily in) Solidity
        curl "https://api.github.com/search/repositories?q=language:Solidity&sort=stars&order=desc&per_page=100&page=$i" > "$fname"

        # This search finds repositories containing Solidity code at all (based on extension and the word "contract", which every Solidity contract has to contain). At least, that's what it was supposed to do...
        # NOTE: This sort of search works on the GitHub website, but the API doesn't support using extension in a repository search.
        # curl "https://api.github.com/search/repositories?q=contract+extension:sol&sort=stars&order=desc&per_page=100&page=$i" > "$fname"
    fi
done

