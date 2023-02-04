#!/bin/bash
set -eu

SRC="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"

docker build -t transpile "${SCRIPT_DIR}"

base=$(basename "${SRC}")
dest="${SCRIPT_DIR}/out/${base%.*}.json"
cat "${SRC}" | docker run -i transpile > "${dest}"
