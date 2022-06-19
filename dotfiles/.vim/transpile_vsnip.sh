#!/bin/bash
set -eu

function transpile() {
  local -r filepath="$1"
  local -r outputpath="$2"
  # FIXME: remove last line
  cat "${filepath}" | yq -o json | jq 'map_values(.body |= split("\n"))' > "${outputpath}"
}

for filepath in $(find ~/.vim/vsnip/src/ -type f); do
  dir=$(dirname ${filepath})
  base=$(basename ${filepath})
  outputpath="${dir}/../out/${base%.*}.json"
  transpile "${filepath}" "${outputpath}"
done
