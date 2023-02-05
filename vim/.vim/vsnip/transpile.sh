#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"

BASE=$(basename "$1")
SRC="src/${BASE}"
DEST="out/${BASE%.*}.json"

docker build -t transpile "${SCRIPT_DIR}"
docker run -v "${SCRIPT_DIR}:/app" transpile "$SRC" -o "$DEST"
