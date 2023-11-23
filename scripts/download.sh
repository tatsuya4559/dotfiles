#!/bin/bash
set -eu

download() {
  local -r url="$1"
  local -r dest="$2"
  if [[ -e $dest ]]; then
    echo "$dest already exists" >&2
    return
  fi
  curl $url -o $dest
}

download "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" "$HOME/.git-completion.bash"
download "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh" "$HOME/.git-prompt.sh"
download "https://raw.githubusercontent.com/git/git/master/contrib/git-jump/git-jump" "$HOME/.local/bin/git-jump"
chmod +x "$HOME/.local/bin/git-jump"
