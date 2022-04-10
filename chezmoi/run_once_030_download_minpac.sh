#!/bin/bash
MINPAC_DIR="$HOME/.vim/pack/minpac"
mkdir -p "${MINPAC_DIR}/"{start,opt}
git clone https://github.com/k-takata/minpac.git "${MINPAC_DIR}/opt/minpac"
