#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"

transpile() {
  local -r src="$1"
  local -r out="$2"
  yq "${src}" -o json | jq 'map_values(.body |= (rtrimstr("\n") | split("\n")))' > "${out}"
}

while read -r src; do
  base=$(basename "${src}")
  out="${SCRIPT_DIR}/out/${base%.*}.json"
  transpile "${src}" "${out}"
done < <(find "${SCRIPT_DIR}/src/" -type f)
