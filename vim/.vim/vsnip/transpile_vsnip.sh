#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"

transpile() {
  local -r src="$1"
  local -r out="$2"
  yj -tj < "${src}" |
    jq '.snippet | map({ (.prefix): . }) | add' |
    jq 'map_values(.body |= (rtrimstr("\n") | split("\n")))' > "${out}"
}

while read -r src; do
  # echo "${src}"
  base=$(basename "${src}")
  out="${SCRIPT_DIR}/out/${base%.*}.json"
  transpile "${src}" "${out}"
done < <(find "${SCRIPT_DIR}/src/" -type f)
